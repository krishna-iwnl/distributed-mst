defmodule FileIO do
    def read(file_name) do
        {:ok,file} = File.open(file_name , [:read])
        file 
        |> IO.read(:all)
        |> String.replace("\n"," ")
        |> String.split()
    end
    
    def get_adj(file_name) do
        data = read(file_name)
        v = Enum.at(data,0) |> String.to_integer
        e = Enum.at(data,1) |> String.to_integer
        IO.inspect v
        IO.inspect e
        data = data |> Enum.slice(2..-1) |> Enum.chunk_every(3)
        IO.inspect data
        res = Enum.map(1..v , fn _x -> [] end)
        res = Enum.reduce(data ,res ,fn x,acc -> 
            to = Enum.at(x,0) |> String.to_integer
            from = Enum.at(x,1)  |> String.to_integer
            dist = Enum.at(x,2) |> String.to_integer
            acc = List.update_at(acc,to,&(&1 ++[{from,dist}])) 
            List.update_at(acc,from,&(&1 ++[{to,dist}])) 
        end) 
        IO.inspect res
    end
end