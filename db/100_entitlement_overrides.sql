-- Entitlement overrides per scope (user or workspace) + early-verified flag.
create table if not exists public.entitlement_overrides (
  id uuid primary key default gen_random_uuid(),
  scope_type text not null check (scope_type in ('user', 'workspace')),
  scope_id uuid not null,
  entitlement_key text not null,
  value text not null,
  granted_by text not null default 'system',
  created_at timestamptz not null default now()
);

create unique index if not exists entitlement_overrides_scope_key_uidx
  on public.entitlement_overrides (scope_type, scope_id, entitlement_key);

alter table public.profiles add column if not exists is_early_verified boolean not null default false;
