'require csv'

module ReadCsv

  def read_csv(file_name)
    CSV.read(file_name)
  end

end
