BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ingredients" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "isAvailable" boolean NOT NULL,
    "isDeleted" boolean NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "menu_items" CASCADE;

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
    "createdAt" timestamp without time zone,
    "ingredients" json,
    "isDeleted" boolean NOT NULL
);


--
-- MIGRATION VERSION FOR pchaa
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pchaa', '20251229090928371', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251229090928371', "timestamp" = now();

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
