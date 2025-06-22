-- 创建留言表 (posts)
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  content TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  views INTEGER DEFAULT 0,
  ip_address VARCHAR(45), -- 存储IP地址用于简单去重
  user_agent TEXT -- 存储用户代理信息
);

-- 创建回复表 (comments)，支持嵌套回复
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  parent_id INTEGER REFERENCES comments(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  ip_address VARCHAR(45),
  user_agent TEXT,
  -- 添加索引提升查询性能
  CONSTRAINT fk_post
    FOREIGN KEY(post_id)
    REFERENCES posts(id)
    ON DELETE CASCADE,
  CONSTRAINT fk_parent_comment
    FOREIGN KEY(parent_id)
    REFERENCES comments(id)
    ON DELETE CASCADE
);

-- 为常用查询添加索引
CREATE INDEX idx_comments_post_id ON comments(post_id);
CREATE INDEX idx_comments_parent_id ON comments(parent_id);
CREATE INDEX idx_posts_created_at ON posts(created_at);

-- 创建浏览量更新函数
CREATE OR REPLACE FUNCTION increment_post_views(post_id INTEGER)
RETURNS VOID AS $$
BEGIN
  UPDATE posts
  SET views = views + 1
  WHERE id = post_id;
END;
$$ LANGUAGE plpgsql;

-- 生成100条模拟留言数据
INSERT INTO posts (content, created_at, views, ip_address, user_agent)
SELECT 
  '这是第 ' || i || ' 条留言内容，分享我的一些想法和感受。',
  NOW() - (random() * 30 || ' days')::interval, -- 随机30天内的时间
  floor(random() * 100)::int, -- 0-99的随机浏览量
  '192.168.' || floor(random()*255) || '.' || floor(random()*255), -- 随机IP
  CASE floor(random()*4)
    WHEN 0 THEN 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/98.0.4758.102'
    WHEN 1 THEN 'Mozilla/5.0 (Macintosh; Intel Mac OS X 12_2_1) Safari/15.3'
    WHEN 2 THEN 'Mozilla/5.0 (Linux; Android 12) Firefox/97.0'
    ELSE 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_3 like Mac OS X) Mobile/15E148'
  END
FROM generate_series(1, 100) AS i;

-- 生成100条模拟回复数据（包含嵌套回复）
INSERT INTO comments (post_id, parent_id, content, created_at, ip_address, user_agent)
SELECT 
  floor(random()*100) + 1, -- 随机关联到1-100的留言
  CASE WHEN random() < 0.3 THEN floor(random()*i) + 1 ELSE NULL END, -- 30%概率有父回复
  '这是对留言的第 ' || i || ' 条回复，很赞同你的观点！',
  NOW() - (random() * 30 || ' days')::interval, -- 随机30天内的时间
  '10.' || floor(random()*255) || '.' || floor(random()*255) || '.' || floor(random()*255), -- 随机IP
  CASE floor(random()*4)
    WHEN 0 THEN 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/98.0.4758.102'
    WHEN 1 THEN 'Mozilla/5.0 (Macintosh; Intel Mac OS X 12_2_1) Safari/15.3'
    WHEN 2 THEN 'Mozilla/5.0 (Linux; Android 12) Firefox/97.0'
    ELSE 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_3 like Mac OS X) Mobile/15E148'
  END
FROM generate_series(1, 100) AS i;