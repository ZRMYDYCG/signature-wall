import type { SearchResponse } from '../types/index'
import { supabase } from '../../../supabase/index'

export async function basicSearch(): Promise<SearchResponse<any[]>> {
  const { data, error, count } = await supabase
    .from('book')
    .select('*', { count: 'exact' })

  if (error) {
    return {
      success: false,
      data: null,
      error: error.message,
      meta: { total: 0 },
    }
  }

  return {
    success: true,
    data: data || [],
    error: null,
    meta: { total: count || 0 },
  }
}
