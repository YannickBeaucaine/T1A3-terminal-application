
require 'artii'
require 'CSV'



class Record
	attr_accessor :artist, :album, :yearofrelease
	def initialize (artist,album, yearofrelease)
      
        @artist = artist
		@album = album
        @yearofrelease = yearofrelease
	end
end



def add_record(records)
    artistname = read_string("Please enter artist name :")
    albumtname = read_string("Please enter album name :")
    year = read_integer("Please enter year of release :")

    record = Record.new(artistname,albumtname,year)
    records <<  record

    puts "Record has been added to your collection"

end


def edit_record(records)
    
    index = read_integer("Please type record number to edit :")
    
    if(index<=records.length && index>0)
        artistname = read_string("Please enter artist name :")
        albumtname = read_string("Please enter album name :")
        year = read_integer("Please enter year of release :")

        records[index-1].artist = artistname
        records[index-1].album = albumtname
        records[index-1].yearofrelease = year
        puts "record has been updated successfully"
    else 
        puts "incorrect record number"
    end 

    
end

def remove_record(records)
    
    index = read_integer("Please type record number to remove :")
    
    if(index<=records.length && index>0)
        records.delete_at(index-1)
        puts "record has been deleted successfully"
    else 
        puts "Incorrect record number"
    end    
end

def save_records(records_file_name,records)
    
    column_header = ["artist","album","year of release"]
    CSV.open(records_file_name, "w",:write_headers=> true,:headers => column_header) do |csv|
        for i in 0...records.length
            csv << [records[i].artist, records[i].album,records[i].yearofrelease]
        end
    end

    puts "Collection Saved Succesfully"

end 

def display_record(record,index)
    puts "#{index+1}. #{record.artist} - #{record.album} - #{record.yearofrelease}"
end 


def display_records(records)
    i = 0;
    while i < records.length
        display_record(records[i],i)
        i +=1
    end 
end 



def read_record(record,record_number)
    
    artist = record[record_number]['artist']
    album = record[record_number]['album']
    yearofrelease = record[record_number]['year of release']
    record = Record.new(artist,album,yearofrelease)
    return record
end 

def read_records(table)
    number_of_record = table.length.to_i
    records =  Array.new()

    for i in 0...number_of_record
        records << read_record(table,i)
    end 
    
    return  records
end 

def load_albums(records_file_name)
    
    if(File.exist?(records_file_name))            
        table = CSV.parse(File.read(records_file_name), headers: true)
        records = read_records(table)
        puts "Collection Loaded Succesfully"   
        
    else
        puts 'File does not exists.Please check if the file is present and the name is correct'
    end 

    return records
end 

        

def main()
    records = []
    finished = false
    records_file_name = './lib/records.csv'

    title = Artii::Base.new
    puts title.asciify('WaxMuseum')

    records  = load_albums(records_file_name)
    
    while finished == false
        puts("---------Menu------------")
        puts("1. Display Collection")
        puts("2. Add Record to Collection")
        puts("3: Edit Record")
        puts("4: Remove Record")
        puts("5: Exit")
    
        selection = read_integer("Choose an option : ")
        case selection
        when 1
            display_records(records)
        when 2
            add_record(records)
        when 3
            edit_record(records)
        when 4
            remove_record(records)
        when 5
            save_records(records_file_name,records)
            finished = true
        else
            puts("Enter options between 1 to 5 ")
        end
        
    end
end

main()