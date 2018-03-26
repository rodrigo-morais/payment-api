# Payment API
This is a simple Payment API in Ruby on Rails following the microservices mindset.

## To execute

In terminal execute:

```sh
$ docker-compose build
$ docker-compose run
```

## To create the database

In terminal execute:

```sh
$ docker-compose run --rm payment rake db:create db:migrate db:seed
```

## To run the tests

In terminal execute:

```sh
$ docker-compose run --rm payment rspec
```

## Endpoints

The API uses a token to authorize the request. For this example it is necessary to add to the request HEADERS:

```
Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlLW1haWwiOiJtb3JhaXMucm1AZ21haWwuY29tIiwibmFtZSI6IlJvZHJpZ28gTW9yYWlzIiwidXVpZCI6MTIzM30.tib1NtKu0wUE1N9ISBDmfh-DOdSDD33yXq_E3XLEZWg
```

As an example this token is validated by the API internally and the same token is used for all calls.
In a real situation an API for authentication should crete and provide the token for the client. An additional API or third party service validates that using JWT.

### GET all transactions

Get all transactions using pagination.

```
http://localhost:3000/transactions
```

It is possible to add page number and number of results per page as a query string:
```
?page=2&per_page=10
```

### GET transaction

Get a transaction with a corresponding ID. If ID does not exist returns 404.

```
http://localhost:3000/transactions/:id
```

### POST transaction

Create a new transaction in the database.

```
http://localhost:3000/transactions

body: {
{
  version: integer,
  organisation_id: integer (The ID of an organisation),
  amount: float,
  currency: string,
  beneficiary_name: string,
  beneficiary_account_number: integer,
  beneficiary_account_number_code: integer,
  beneficiary_bank_id: integer,
  beneficiary_bank_id_code: integer,
  debtor_name: string,
  debtor_account_number: integer,
  debtor_account_number_code: integer,
  debtor_bank_id: integer,
  debtor_bank_id_code: integer
}
```

### DELETE transaction

Updates the transaction status with the corresponding ID from `CREATED` to `CANCELED`. If ID does not exist returns 404.

```
http://localhost:3000/transactions/:id
```
