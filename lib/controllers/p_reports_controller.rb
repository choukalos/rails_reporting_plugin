require "spreadsheet/excel"
require 'iconv'

class PReportsController < ApplicationController
  include Spreadsheet
  
  # GET /p_reports
  # GET /p_reports.xml
  def index
    @p_reports = PReport.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @p_reports }
    end
  end

  # GET /p_reports/1
  # GET /p_reports/1.xml
  def show
    @p_report = PReport.find(params[:id])
    @data = @p_report.run

    respond_to do |format|
      format.html { }  # show.html.erb
      format.xml  { render :xml => @data }
      format.csv  { render :text => create_csv_table(@data) 
                    headers['Content-Disposition'] = "attachment; filename=\"#{@p_report.name.downcase.gsub(/\s+/, '_')}_#{Date.today.to_s}.csv\"" }
      format.xls  { render :text => create_excel_table(@data)
                    headers['Content-Disposition'] = "attachment; filename=\"#{@p_report.name.downcase.gsub(/\s+/, '_')}_#{Date.today.to_s}.xls\""
                    headers['Cache-Control'] = '' }
    end
  end

  # GET /p_reports/new
  # GET /p_reports/new.xml
  def new
    @p_report = PReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @p_report }
    end
  end

  # GET /p_reports/1/edit
  def edit
    @p_report = PReport.find(params[:id])
  end

  # POST /p_reports
  # POST /p_reports.xml
  def create
    @p_report = PReport.new(params[:p_report])

    respond_to do |format|
      if @p_report.save
        flash[:notice] = 'PReport was successfully created.'
        format.html { redirect_to(@p_report) }
        format.xml  { render :xml => @p_report, :status => :created, :location => @p_report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @p_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /p_reports/1
  # PUT /p_reports/1.xml
  def update
    @p_report = PReport.find(params[:id])

    respond_to do |format|
      if @p_report.update_attributes(params[:p_report])
        flash[:notice] = 'PReport was successfully updated.'
        format.html { redirect_to(@p_report) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @p_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /p_reports/1
  # DELETE /p_reports/1.xml
  def destroy
    @p_report = PReport.find(params[:id])
    @p_report.destroy

    respond_to do |format|
      format.html { redirect_to(p_reports_url) }
      format.xml  { head :ok }
    end
  end
  
  # Private Functions
  private
    
  def create_csv_table(_table)
    _table.inject('') do |table, row|
      table << row.map {|cell| cell.to_s.gsub(/\s+/, ' ')}.join(';')
      table << "\n"
    end
  end
  
  def create_excel_table(_table)
    out = StringIO.new
    workbook = Excel.new(out)
    format = Format.new
    
    worksheet = workbook.add_worksheet
    _table.each_with_index do |row, i| 
      row.each_with_index do |col, j|
        worksheet.write i, j, convert_encoding(col.to_s), format # excel doesn't seem to like utf-8
      end
    end
    
    workbook.close
    out.string
  end
  
  def convert_encoding(string)
    begin
      Iconv.conv('ISO-8859-1', 'UTF-8', string)
    rescue Iconv::IllegalSequence, Iconv::InvalidCharacter
      string
    end
  end
  
end
