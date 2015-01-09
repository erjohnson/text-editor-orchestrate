class DocumentsController < ApplicationController

  def index
    @documents = app[:documents]
  end

  def new
  end

  def create
    @document = app[:documents].create({ title: params[:title] })
    respond_to do |format|
      format.html { redirect_to document_url(@document.key), notice: "Document Created." }
    end
  end

  def show
    @res = client.get(:documents, params[:id])
    @res.on_complete do
      if @res.success?
        @title = @res.body['title']
        @content = @res.body['content']
      else
        redirect_to root_url, alert: "Could not find document."
      end
    end
  end

  def update
    @res = client.put(:documents, params[:id], { title: params[:title], content: params[:content] })
    @res.on_complete do
      if @res.success?
        respond_to do |format|
          format.js
        end
      else
        redirect_to document_url(params[:id]), alert: "Could not save document."
      end
    end
  end

  def undo
    @prev_val
    options = { limit: 1, offset: 1, values: true }
    @prev_ref = client.list_refs(:documents, params[:id], options)
    @prev_ref.on_complete do
      @prev_val = @prev_ref.results.first['value']
    end

    @res = client.put(:documents, params[:id], @prev_val)
    @content = @prev_val['content']
    respond_to do |format|
      format.js
    end
  end

end
