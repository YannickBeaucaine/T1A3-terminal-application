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