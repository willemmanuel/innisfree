class ReportPdf < Prawn::Document
  def initialize(data)
    super()
    @users = data
    header
    text_content
    table_content
  end

  def header
    #This inserts an image in the pdf file and sets the size of the image
    image "#{Rails.root}/app/assets/images/pdf_header.png", width: 400, height: 110, :position => :center
    move_down 25
  end

  def text_content
    #text "Hello, World!"
  end

  def table_content

    table product_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [150, 150, 110, 100]
    end

  end

  def product_rows
    [['Name', 'Email', 'Phone', 'House']] +
        @users.map do |data|

          if data.name != nil
            @name = data.name
          else
            @name = ""
          end

          if data.phone != nil
            @phone = data.phone
          else
            @phone = ""
          end

          if data.email != nil
            @email = data.email
          else
            @email = ""
          end

          if data.house_id != nil
            @house = House.where('id = ?', data.house_id).first.name
          else
            @house = ""
          end

          [@name,
           @email,
           @phone,
           @house]
        end
  end



end