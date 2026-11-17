# calendar

にほんご カレンダー あそび（GitHub Pages）

- `calendar_quiz.html` … 生徒用アプリ本体（ログイン → 6つの練習・ゲーム。結果は Supabase に記録）
- ログイン画面の下の「先生はこちら」から先生用ページ（生徒ごとの履歴・得意/苦手の分析）
- `supabase_setup.sql` … 記録用テーブル（cal_sessions / cal_answers）。Supabase の SQL Editor で1回実行
- 生徒リスト（students）は Kanji Practice と共有
