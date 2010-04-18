# t.string :name
# t.string :photo_url
# t.belongs_to :parliamentary_group
# t.belongs_to :political_party
# t.string :email
# t.string :url

class Deputy < ActiveRecord::Base
  belongs_to :parliamentary_group
  belongs_to :political_party
  
  has_and_belongs_to_many :initiatives
  
  
  delegate :name, :to => :parliamentary_group, :prefix => true, :allow_nil => true
  delegate :name, :to => :political_party, :prefix => true, :allow_nil => true
  
  named_scope :by_initiatives, {:order => 'initiatives_count DESC'}
  
  class << self
    def load
      Scrapper.new do |scrapper|
        scrapper.visit('http://www.congreso.es/portal/page/portal/Congreso/Congreso/Diputados')
        scrapper.click_link("Listado completo de la composici\303\263n de la C\303\241mara")

        total = scrapper.doc.at_css('.SUBTITULO_CONTENIDO span').inner_html.to_i
        pbar = ProgressBar.new('Deputy', total)
        begin 
          scrapper.within('.listado_1') do
            scrapper.doc.css('li').each do |li|
              a = li.at_css('a')

              name = a.inner_html
              url  = a["href"] 
              group = li.at_css('span').inner_html

              d = find_or_create_by_name(name)
              d.url = "http://www.congreso.es"+url
              d.parliamentary_group = ::ParliamentaryGroup.find_or_create_by_name(group)
              d.save 
              pbar.inc rescue nil

            end
          end
          scrapper.click_link("Página siguiente") rescue break
        end while scrapper.doc.css('.listado_1 li').size > 0

        pbar.finish

      end
    end
    
    def load_details
      find_each { |deputy| deputy.load_details }
    end
    
    
    def load_initiatives
      find_each { |deputy| deputy.load_initiatives }
    end
    
  end
  
  def congress_id
    url.match(/idDiputado=(\d*)/)[1].to_i
  end

  def initiatives_url(start_page=1, end_page=200)
    "http://www.congreso.es/portal/page/portal/Congreso/Congreso/Iniciativas?_piref73_2148295_73_1335437_1335437.next_page=/wc/servidorCGI&CMD=VERLST&BASE=IWI9&FMT=INITXLUS.fmt&DOCS=#{start_page}-#{end_page}&DOCORDER=FIFO&OPDEF=Y&QUERY=(I).ACIN1.+%26+(#{scapped_name}).SAUT."
  end
  
  def scapped_name
    CGI.escape(name.gsub('ª',' '))
  end

  def speeches_url
    "http://www.congreso.es/portal/page/portal/Congreso/Congreso/Diputados/BusqForm?_piref73_1333155_73_1333154_1333154.next_page=/wc/buscarIntervencionesForm&idDiputado=#{congress_id}&tipoIntervenciones=tipo&idLegislatura=9&muestraLeg=false"
#    "http://www.congreso.es/portal/page/portal/Congreso/Congreso/Diputados/BusqForm?_piref73_1333155_73_1333154_1333154.next_page=/wc/buscarIntervencionesForm&idDiputado=#{congress_id}&tipoIntervenciones=crono&idLegislatura=9&muestraLeg=false"
  end
  
  
  
  
  def load_details
    Scrapper.new do |scrapper|
      scrapper.visit(url)
      self.email = scrapper.at_css('.correo_dip a').inner_html rescue nil
      self.photo_url = "http://www.congreso.es"+scrapper.css('p.logo_grupo img').first["src"]
      
      pp_name = scrapper.at_css('p.nombre_grupo').inner_html
      pp_photo_url = scrapper.at_css('p.logo_grupo a img')["src"] rescue ""
      self.political_party = PoliticalParty.find_or_create_by_name(pp_name)
      self.political_party.update_attribute(:logo_url, "http://www.congreso.es"+pp_photo_url)
      self.save
    end
  end
  handle_asynchronously :load_details
  
  
  
  def load_initiatives
    Scrapper.new do |scrapper|
      scrapper.visit(initiatives_url(1,1))
      self.initiatives_count = (scrapper.at_css('#RESULTADOS_BUSQUEDA .SUBTITULO_CONTENIDO span').inner_html.to_i rescue 0)
      self.save
    end
  end
  handle_asynchronously :load_initiatives
  
end
