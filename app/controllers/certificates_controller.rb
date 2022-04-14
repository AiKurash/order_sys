class CertificatesController < ApplicationController
  before_action :find_order
  before_action :find_certificate, only: [:edit, :show, :update, :destroy]

  def new
    @certificate = Certificate.new
  end

  def create
    @certificate = Certificate.new(certificate_params)
    @certificate.order_id = @order.id
    @certificate.user_id = current_user.id

    if @certificate.save
      #redirect_to order_path(@order)
      redirect_to order_certificate_path(@order, @certificate)
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @certificate.update(certificate_params)
          #redirect_to order_path(@order)
          redirect_to order_certificate_path(@order, @certificate)
    else
       render 'edit'
    end
  end


  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@certificate.comment}",
        page_size: 'B5',
        height: '160',
        template: "certificates/show.pdf.erb",
        layout: "pdf.html.erb",
        orientation: "Portrait",
        lowquality: true,
        zoom: 1.80,
        dpi: 98

      end
    end
  end

  private

    def certificate_params
      params.require(:certificate).permit(:Hag, :comment, :course_id)
    end

    def find_order
      @order = Order.find(params[:order_id])
    end

    def find_certificate
      @order = Order.find(params[:order_id])
      @certificate = Certificate.find(params[:id])
    end

end
