import type { PaginationResponse } from '../types/index'
import { supabase } from '../../../supabase/index'

interface SearchFilter {
  /** 书名关键词过滤 (模糊匹配) */
  name?: string
  /** 最低价格过滤 */
  minPrice?: number
  /** 最高价格过滤 */
  maxPrice?: number
  /** 其他可能的过滤字段 */
  [key: string]: any
}

export async function filterSearch(
  currentPage: number = 1,
  perPage: number = 10,
  filter: SearchFilter = {},
): Promise<PaginationResponse<any>> {
  // 计算分页偏移量
  const from = (currentPage - 1) * perPage
  const to = from + perPage - 1

  // 构建基础查询
  let query = supabase
    .from('book')
    .select('*', { count: 'exact' })

  // 动态添加过滤条件
  if (filter.name) {
    // 书名模糊搜索 (使用Supabase的ilike操作符实现不区分大小写的模糊匹配)
    query = query.ilike('name', `%${filter.name}%`)
  }

  if (filter.minPrice !== undefined) {
    // 价格大于等于最小值
    query = query.gte('price', filter.minPrice)
  }

  if (filter.maxPrice !== undefined) {
    // 价格小于等于最大值
    query = query.lte('price', filter.maxPrice)
  }

  // 添加其他自定义过滤条件
  Object.entries(filter).forEach(([key, value]) => {
    // 跳过已处理的过滤字段
    if (['name', 'minPrice', 'maxPrice'].includes(key))
      return

    // 对其他字段进行精确匹配
    if (value !== undefined && value !== null) {
      query = query.eq(key, value)
    }
  })

  // 应用分页
  query = query.range(from, to)

  // 执行查询
  const { data, error, count } = await query

  // 错误处理
  if (error) {
    return {
      success: false,
      data: [],
      error: error.message,
      meta: {
        total: 0,
        current_page: currentPage,
        per_page: perPage,
      },
    }
  }

  // 返回成功响应
  return {
    success: true,
    data: data || [],
    error: null,
    meta: {
      total: count || 0,
      current_page: currentPage,
      per_page: perPage,
    },
  }
}
