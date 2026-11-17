-- カレンダーゲーム用の記録テーブル
-- Supabase の SQL Editor に貼り付けて「Run」を1回押してください（何度押しても大丈夫です）
-- students テーブルは Kanji Practice と共有します（新しく作る必要はありません）

create table if not exists cal_sessions (
  id           uuid primary key,
  student_id   uuid not null references students(id) on delete cascade,
  mode         text not null,          -- quiz / explore / train / memory / survival / story
  started_at   timestamptz not null,
  ended_at     timestamptz,
  duration_sec int,
  total        int default 0,          -- 問題数（ペアさがしは手数）
  correct      int default 0,          -- 正解数
  finished     boolean default false,  -- 最後まで遊んだか
  stars        int,
  meta         jsonb
);

create table if not exists cal_answers (
  id          bigint generated always as identity primary key,
  student_id  uuid not null references students(id) on delete cascade,
  session_id  uuid,
  mode        text not null,
  skill       text not null,           -- month / day / weekday / tw-day / tw-week / tw-month / tw-year / date-calc
  item        text,                    -- 例: ふつか, あした, せんしゅう
  correct     boolean not null,
  given       text,                    -- 生徒さんが選んだ・書いた答え
  created_at  timestamptz default now()
);

create index if not exists cal_sessions_student_idx on cal_sessions (student_id, started_at desc);
create index if not exists cal_answers_student_idx  on cal_answers  (student_id, created_at desc);

alter table cal_sessions enable row level security;
alter table cal_answers  enable row level security;

drop policy if exists "cal_sessions anon all" on cal_sessions;
create policy "cal_sessions anon all" on cal_sessions for all to anon using (true) with check (true);

drop policy if exists "cal_answers anon all" on cal_answers;
create policy "cal_answers anon all" on cal_answers for all to anon using (true) with check (true);
