
CREATE TABLE "CardHolder" (
    "id" int   NOT NULL,
    "Name" string   NOT NULL,
    CONSTRAINT "pk_CardHolder" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "CreditCard" (
    "card" VARCHAR(20)   NOT NULL,
    "cardholder_id" int   NOT NULL,
    CONSTRAINT "pk_CreditCard" PRIMARY KEY (
        "card"
     )
);

CREATE TABLE "merchant" (
    "id" int   NOT NULL,
    "name" int   NOT NULL,
    "id_merchant_category" int   NOT NULL,
    CONSTRAINT "pk_merchant" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "MerchantCategory" (
    "id" int   NOT NULL,
    "Name" string   NOT NULL,
    CONSTRAINT "pk_MerchantCategory" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "Transaction" (
    "id" int   NOT NULL,
    "date" timestamp   NOT NULL,
    "amount" int   NOT NULL,
    "card" VARCHAR(20)   NOT NULL,
    "id_merchant" int   NOT NULL,
    CONSTRAINT "pk_Transaction" PRIMARY KEY (
        "id"
     )
);

ALTER TABLE "CreditCard" ADD CONSTRAINT "fk_CreditCard_cardholder_id" FOREIGN KEY("cardholder_id")
REFERENCES "CardHolder" ("id");

ALTER TABLE "merchant" ADD CONSTRAINT "fk_merchant_id_merchant_category" FOREIGN KEY("id_merchant_category")
REFERENCES "MerchantCategory" ("id");

ALTER TABLE "Transaction" ADD CONSTRAINT "fk_Transaction_card" FOREIGN KEY("card")
REFERENCES "CreditCard" ("card");

ALTER TABLE "Transaction" ADD CONSTRAINT "fk_Transaction_id_merchant" FOREIGN KEY("id_merchant")
REFERENCES "merchant" ("id");

