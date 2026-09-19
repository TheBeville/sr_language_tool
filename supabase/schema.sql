-- Supabase schema for sr_language_tool
--
-- sync_id (UUID) is the cross-device record identity and is the primary key.
-- The local integer id is stored as data for reference.
-- last_modified enables per-record last-write-wins conflict resolution.
-- Sync order: languages → categories → genders → cards (FK dependency).
--
-- Run this in the Supabase SQL editor before implementing sync logic.

-- ------------------------------------------------------------------ --
-- languages
-- ------------------------------------------------------------------ --

CREATE TABLE IF NOT EXISTS public.languages (
  sync_id       UUID        PRIMARY KEY,
  id            BIGINT      NOT NULL,
  user_id       UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  language      TEXT        NOT NULL,
  last_modified TIMESTAMPTZ NOT NULL
);

ALTER TABLE public.languages ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies WHERE tablename = 'languages' AND policyname = 'users_own_languages'
  ) THEN
    CREATE POLICY "users_own_languages" ON public.languages
      FOR ALL USING (auth.uid() = user_id);
  END IF;
END $$;

-- ------------------------------------------------------------------ --
-- categories
-- ------------------------------------------------------------------ --

CREATE TABLE IF NOT EXISTS public.categories (
  sync_id       UUID        PRIMARY KEY,
  id            BIGINT      NOT NULL,
  user_id       UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  category      TEXT        NOT NULL,
  last_modified TIMESTAMPTZ NOT NULL
);

ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies WHERE tablename = 'categories' AND policyname = 'users_own_categories'
  ) THEN
    CREATE POLICY "users_own_categories" ON public.categories
      FOR ALL USING (auth.uid() = user_id);
  END IF;
END $$;

-- ------------------------------------------------------------------ --
-- genders
-- ------------------------------------------------------------------ --

CREATE TABLE IF NOT EXISTS public.genders (
  sync_id          UUID        PRIMARY KEY,
  id               BIGINT      NOT NULL,
  user_id          UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  language_sync_id UUID        NOT NULL REFERENCES public.languages(sync_id) ON DELETE CASCADE,
  gender           TEXT        NOT NULL,
  last_modified    TIMESTAMPTZ NOT NULL
);

ALTER TABLE public.genders ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies WHERE tablename = 'genders' AND policyname = 'users_own_genders'
  ) THEN
    CREATE POLICY "users_own_genders" ON public.genders
      FOR ALL USING (auth.uid() = user_id);
  END IF;
END $$;

-- ------------------------------------------------------------------ --
-- cards
-- ------------------------------------------------------------------ --

CREATE TABLE IF NOT EXISTS public.cards (
  sync_id          UUID        PRIMARY KEY,
  id               BIGINT      NOT NULL,
  user_id          UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  language_sync_id UUID        NOT NULL REFERENCES public.languages(sync_id) ON DELETE CASCADE,
  category_sync_id UUID        NOT NULL REFERENCES public.categories(sync_id) ON DELETE CASCADE,
  front_content    TEXT        NOT NULL,
  reveal_content   TEXT        NOT NULL,
  pronunciation    TEXT,
  example_usage    TEXT,
  plural_form      TEXT,
  gender           TEXT,
  last_review      TIMESTAMPTZ NOT NULL,
  next_review_due  TIMESTAMPTZ NOT NULL,
  last_modified    TIMESTAMPTZ NOT NULL
);

ALTER TABLE public.cards ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies WHERE tablename = 'cards' AND policyname = 'users_own_cards'
  ) THEN
    CREATE POLICY "users_own_cards" ON public.cards
      FOR ALL USING (auth.uid() = user_id);
  END IF;
END $$;

-- ------------------------------------------------------------------ --
-- deleted_records (tombstones for synchronization)
-- ------------------------------------------------------------------ --

CREATE TABLE IF NOT EXISTS public.deleted_records (
  sync_id       UUID        PRIMARY KEY,
  user_id       UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  table_name    TEXT        NOT NULL,
  deleted_at    TIMESTAMPTZ NOT NULL
);

ALTER TABLE public.deleted_records ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies WHERE tablename = 'deleted_records' AND policyname = 'users_own_deleted_records'
  ) THEN
    CREATE POLICY "users_own_deleted_records" ON public.deleted_records
      FOR ALL USING (auth.uid() = user_id);
  END IF;
END $$;
