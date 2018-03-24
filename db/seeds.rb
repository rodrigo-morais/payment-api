organisation_list = [
  "Org 1",
  "Org 2",
  "Org 3",
  "Org 4"
]

organisation_list.each do |name|
    Organisation.create( name: name )
end


200.times do
  offset = rand(Organisation.count)
  org = Organisation.offset(offset).first
  
  Transaction.create( version: 0, organisation_id: org.id )
end
