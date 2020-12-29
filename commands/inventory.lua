local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !inventory")
  print(#mt)
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  if mt[1] == "" then
    mt[1] = "1"
  end
  print(mt[1])
  local pagenumber = math.floor(tonumber(mt[1]))
  
  if pagenumber < 1 then
    pagenumber = 1
  end
  local numkey = 0
  for k,v in pairs(uj.inventory) do
    numkey = numkey + 1
  end
  local maxpn = math.ceil(numkey / 10)
  print("maxpn " .. numkey/10)

  if pagenumber > maxpn then
    pagenumber = maxpn
  end
  print("pagenumber " .. pagenumber)
  local invtable = {}
  local invstring = ''
  for k,v in pairs(uj.inventory) do
    table.insert(invtable, "**" .. (fntoname(k) or k) .. "** x" .. v .. "\n")
  end
  table.sort(invtable)
  for i=(pagenumber-1)*10+1,(pagenumber)*10 do
    print(i)
    if invtable[i] then
      invstring = invstring .. invtable[i]
    end
  end
  message.channel:send("Your inventory contains:\n" .. invstring .. "(page ".. pagenumber .. " of " .. maxpn .. ")")
end
return command
  