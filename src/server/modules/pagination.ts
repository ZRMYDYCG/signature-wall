import type { PaginationResponse } from '../types/index'
import { supabase } from '../../../supabase/index'

export async function paginationSearch(
  currentPage: number = 1,
  perPage: number = 10,
): Promise<PaginationResponse<any>> {
  // 计算分页偏移量
  const from = (currentPage - 1) * perPage
  const to = from + perPage - 1

  const { data, error, count } = await supabase
    .from('book')
    .select('*', { count: 'exact' })
    .range(from, to)

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
