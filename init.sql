-- 主留言表
CREATE TABLE wall_messages (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,  -- 自增主键
    content TEXT NOT NULL,                              -- 留言内容
    signature VARCHAR(100) DEFAULT 'Anonymous',         -- 用户签名（默认匿名）
    avatar_url VARCHAR(255) DEFAULT '',                 -- 头像URL（可空）
    view_count INT NOT NULL DEFAULT 0,                  -- 浏览量统计
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()       -- 创建时间
);

-- 回复表（支持无限嵌套）
CREATE TABLE replies (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,  -- 自增主键
    message_id BIGINT NOT NULL REFERENCES wall_messages(id) ON DELETE CASCADE,  -- 关联主留言
    parent_reply_id BIGINT REFERENCES replies(id) ON DELETE CASCADE,  -- 父级回复ID（实现嵌套）
    content TEXT NOT NULL,                              -- 回复内容
    signature VARCHAR(100) DEFAULT 'Anonymous',         -- 回复者签名
    avatar_url VARCHAR(255) DEFAULT '',                 -- 回复者头像
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()       -- 创建时间
);

-- 索引优化（提升查询性能）
CREATE INDEX idx_wall_messages_created ON wall_messages(created_at DESC);
CREATE INDEX idx_replies_message ON replies(message_id);
CREATE INDEX idx_replies_parent ON replies(parent_reply_id);

-- 插入100条主留言
INSERT INTO wall_messages (content, signature, avatar_url)
SELECT 
  '留言内容-' || generate_series(1,100),
  CASE WHEN random() < 0.3 THEN 'Anonymous' 
       ELSE '用户-' || (floor(random()*10000))::TEXT 
  END,
  CASE WHEN random() < 0.4 THEN '' 
       ELSE 'https://avatar.site/user/' || (floor(random()*1000))::TEXT || '.png' 
  END
FROM generate_series(1,100);

-- 插入随机回复（约300-500条）
WITH messages AS (
  SELECT id FROM wall_messages ORDER BY random() LIMIT 100
)
INSERT INTO replies (message_id, parent_reply_id, content, signature, avatar_url)
SELECT
  m.id,
  NULL,  -- 顶级回复
  '回复主留言-' || (row_number() OVER ()),
  CASE WHEN random() < 0.25 THEN 'Anonymous' 
       ELSE '回复者-' || (floor(random()*500))::TEXT 
  END,
  CASE WHEN random() < 0.3 THEN '' 
       ELSE 'https://avatar.site/reply/' || (floor(random()*500))::TEXT || '.png' 
  END
FROM messages m
CROSS JOIN generate_series(1, (3 + random()*2)::INT);  -- 每条留言3-5条顶级回复

-- 插入二级嵌套回复（约600-1000条）
WITH top_replies AS (
  SELECT r.id, r.message_id 
  FROM replies r 
  WHERE parent_reply_id IS NULL
  ORDER BY random() LIMIT 300
)
INSERT INTO replies (message_id, parent_reply_id, content, signature, avatar_url)
SELECT
  tr.message_id,
  tr.id,  -- 父回复ID
  '嵌套回复-' || (row_number() OVER ()),
  CASE WHEN random() < 0.2 THEN 'Anonymous' 
       ELSE '用户-' || (floor(random()*800))::TEXT 
  END,
  CASE WHEN random() < 0.35 THEN '' 
       ELSE 'https://avatar.site/nested/' || (floor(random()*700))::TEXT || '.png' 
  END
FROM top_replies tr
CROSS JOIN generate_series(1, (1 + random()*2)::INT);  -- 每条回复1-3条嵌套回复

-- 插入三级嵌套回复（约300-500条）
WITH second_level AS (
  SELECT r.id, r.message_id 
  FROM replies r 
  WHERE parent_reply_id IS NOT NULL  -- 只选择二级回复
  ORDER BY random() LIMIT 600
)
INSERT INTO replies (message_id, parent_reply_id, content, signature, avatar_url)
SELECT
  sl.message_id,
  sl.id,  -- 父回复ID
  '深度回复-' || (row_number() OVER ()),
  CASE WHEN random() < 0.15 THEN 'Anonymous' 
       ELSE '用户-' || (floor(random()*1000))::TEXT 
  END,
  CASE WHEN random() < 0.4 THEN '' 
       ELSE 'https://avatar.site/deep/' || (floor(random()*900))::TEXT || '.png' 
  END
FROM second_level sl
CROSS JOIN generate_series(1, (0.5 + random()*1.5)::INT);  -- 50%概率有1-2条回复

-- 随机更新浏览量 (0-500次)
UPDATE wall_messages 
SET view_count = view_count + (random()*100)::INT
WHERE random() < 0.7;  -- 70%的留言有浏览量

-- 设置热门留言（前5%有高浏览量）
UPDATE wall_messages 
SET view_count = view_count + 500 + (random()*1000)::INT
WHERE id IN (
  SELECT id 
  FROM wall_messages 
  ORDER BY random() 
  LIMIT (SELECT count(*)*0.05 FROM wall_messages)
);
