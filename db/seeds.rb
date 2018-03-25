organisation_list = [
  "Org 1",
  "Org 2",
  "Org 3",
  "Org 4"
]

organisation_list.each do |name|
    Organisation.create( name: name )
end


200.times do |i|
  offset = rand(Organisation.count)
  org = Organisation.offset(offset).first
  
  Transaction.create(
    version: 0,
    organisation_id: org.id,
    amount: rand(10000),
    currency: "USD",
    beneficiary_name: "name #{i}",
    beneficiary_account_number: rand(200),
    beneficiary_account_number_code: rand(200),
    beneficiary_bank_id: rand(200),
    beneficiary_bank_id_code: rand(200),
    debtor_name: "name #{i}",
    debtor_account_number: rand(200),
    debtor_account_number_code: rand(200),
    debtor_bank_id: rand(200),
    debtor_bank_id_code: rand(200)
  )
end
