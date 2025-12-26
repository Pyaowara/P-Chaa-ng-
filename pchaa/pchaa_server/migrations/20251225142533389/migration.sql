BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "carts" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "menuItemId" bigint NOT NULL,
    "selectedOptions" json NOT NULL,
    "additionalMessage" text,
    "quantity" bigint NOT NULL,
    "unitPrice" double precision NOT NULL,
    "totalPrice" double precision NOT NULL,
    "createdAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "daily_queue_counters" (
    "id" bigserial PRIMARY KEY,
    "queueDate" timestamp without time zone NOT NULL,
    "iCount" bigint NOT NULL,
    "sCount" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "menu_items" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "basePrice" double precision NOT NULL,
    "timeToPrepare" bigint NOT NULL,
    "customization" json NOT NULL,
    "s3Key" text,
    "isAvailable" boolean NOT NULL,
    "createdAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "order_items" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "menuItemId" bigint,
    "itemName" text NOT NULL,
    "selectedOptions" json NOT NULL,
    "additionalMessage" text,
    "quantity" bigint NOT NULL,
    "finalPrice" double precision NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "orders" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "status" text NOT NULL,
    "type" text NOT NULL,
    "pickupTime" timestamp without time zone,
    "queueNumber" text,
    "replyMessage" text,
    "totalOrderPrice" double precision NOT NULL,
    "orderDate" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "store_settings" (
    "id" bigserial PRIMARY KEY,
    "isOpen" boolean NOT NULL,
    "openTime" text NOT NULL,
    "closeTime" text NOT NULL,
    "autoOpenClose" boolean NOT NULL,
    "s3Key" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "users" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "fullName" text NOT NULL,
    "picture" text,
    "phoneNumber" text,
    "role" text NOT NULL,
    "createdAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_key" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "hash" text NOT NULL,
    "scopeNames" json NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_auth_key_userId_idx" ON "serverpod_auth_key" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_auth" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_email" ON "serverpod_email_auth" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_create_request" (
    "id" bigserial PRIMARY KEY,
    "userName" text NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL,
    "verificationCode" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_create_account_request_idx" ON "serverpod_email_create_request" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_failed_sign_in" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "ipAddress" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_email_failed_sign_in_email_idx" ON "serverpod_email_failed_sign_in" USING btree ("email");
CREATE INDEX "serverpod_email_failed_sign_in_time_idx" ON "serverpod_email_failed_sign_in" USING btree ("time");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_reset" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "verificationCode" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_reset_verification_idx" ON "serverpod_email_reset" USING btree ("verificationCode");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_google_refresh_token" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "refreshToken" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_google_refresh_token_userId_idx" ON "serverpod_google_refresh_token" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_user_image" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "version" bigint NOT NULL,
    "url" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_user_image_user_id" ON "serverpod_user_image" USING btree ("userId", "version");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_user_info" (
    "id" bigserial PRIMARY KEY,
    "userIdentifier" text NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "created" timestamp without time zone NOT NULL,
    "imageUrl" text,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_user_info_user_identifier" ON "serverpod_user_info" USING btree ("userIdentifier");
CREATE INDEX "serverpod_user_info_email" ON "serverpod_user_info" USING btree ("email");


--
-- MIGRATION VERSION FOR pchaa
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pchaa', '20251225142533389', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251225142533389', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20251208110420531-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110420531-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20250825102351908-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250825102351908-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();


COMMIT;
