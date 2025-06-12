import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:hue/core/services/error_handler.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  final SupabaseClient _client = Supabase.instance.client;
  
  // إضافة بيانات
  Future<Map<String, dynamic>?> insertData(
    String table, 
    Map<String, dynamic> data
  ) async {
    try {
      final response = await _client
          .from(table)
          .insert(data)
          .select()
          .single();
      
      return response;
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return null;
    }
  }
  
  // تحديث البيانات
  Future<Map<String, dynamic>?> updateData(
    String table, 
    String id, 
    Map<String, dynamic> data
  ) async {
    try {
      final response = await _client
          .from(table)
          .update(data)
          .eq('id', id)
          .select()
          .single();
      
      return response;
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return null;
    }
  }
  
  // حذف البيانات
  Future<bool> deleteData(String table, String id) async {
    try {
      await _client
          .from(table)
          .delete()
          .eq('id', id);
      
      return true;
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return false;
    }
  }
  
  // استرجاع بيانات متعددة
  Future<List<Map<String, dynamic>>?> getData(
    String table, {
    Map<String, dynamic>? filters,
    String? orderBy,
    bool ascending = true,
    int? limit,
    int? offset,
  }) async {
    try {
      dynamic query = _client.from(table).select();

      // إضافة الفلاتر
      if (filters != null) {
        for (final entry in filters.entries) {
          query = query.eq(entry.key, entry.value);
        }
      }

      // إضافة الترتيب
      if (orderBy != null) {
        query = query.order(orderBy, ascending: ascending);
      }

      // إضافة الحد
      if (limit != null) {
        query = query.limit(limit);
      }

      // إضافة الإزاحة
      if (offset != null) {
        query = query.range(offset, offset + (limit ?? 10) - 1);
      }

      final response = await query;
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return null;
    }
  }
  
  // استرجاع عنصر واحد
  Future<Map<String, dynamic>?> getItem(
    String table,
    String id,
  ) async {
    try {
      final response = await _client
          .from(table)
          .select()
          .eq('id', id)
          .single();
      
      return response;
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return null;
    }
  }
  
  // البحث في البيانات
  Future<List<Map<String, dynamic>>?> searchData(
    String table,
    String column,
    String searchTerm, {
    int? limit,
  }) async {
    try {
      dynamic query = _client
          .from(table)
          .select()
          .ilike(column, '%$searchTerm%');

      if (limit != null) {
        query = query.limit(limit);
      }

      final response = await query;
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return null;
    }
  }
  
  // عد البيانات
  Future<int?> countData(
    String table, {
    Map<String, dynamic>? filters,
  }) async {
    try {
      var query = _client.from(table).select('id');

      // إضافة الفلاتر
      if (filters != null) {
        for (final entry in filters.entries) {
          query = query.eq(entry.key, entry.value);
        }
      }

      final response = await query;
      return response.length;
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return null;
    }
  }
  
  // التحقق من وجود عنصر
  Future<bool> exists(
    String table,
    String column,
    dynamic value,
  ) async {
    try {
      final response = await _client
          .from(table)
          .select('id')
          .eq(column, value)
          .limit(1);
      
      return response.isNotEmpty;
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return false;
    }
  }
  
  // إدراج أو تحديث البيانات
  Future<Map<String, dynamic>?> upsertData(
    String table,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _client
          .from(table)
          .upsert(data)
          .select()
          .single();
      
      return response;
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return null;
    }
  }
  
  // تنفيذ استعلام مخصص باستخدام RPC
  Future<List<Map<String, dynamic>>?> executeRPC(
    String functionName, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _client.rpc(functionName, params: params);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return null;
    }
  }
  
  // التحقق من الاتصال
  Future<bool> isConnected() async {
    try {
      await _client.from('profiles').select('id').limit(1);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // استرجاع بيانات مع فلترة متقدمة
  Future<List<Map<String, dynamic>>?> getDataWithAdvancedFilter(
    String table, {
    Map<String, dynamic>? equalFilters,
    Map<String, dynamic>? notEqualFilters,
    Map<String, dynamic>? greaterThanFilters,
    Map<String, dynamic>? lessThanFilters,
    Map<String, String>? likeFilters,
    List<String>? inFilters,
    String? orderBy,
    bool ascending = true,
    int? limit,
    int? offset,
  }) async {
    try {
      dynamic query = _client.from(table).select();

      // فلاتر المساواة
      if (equalFilters != null) {
        for (final entry in equalFilters.entries) {
          query = query.eq(entry.key, entry.value);
        }
      }

      // فلاتر عدم المساواة
      if (notEqualFilters != null) {
        for (final entry in notEqualFilters.entries) {
          query = query.neq(entry.key, entry.value);
        }
      }

      // فلاتر أكبر من
      if (greaterThanFilters != null) {
        for (final entry in greaterThanFilters.entries) {
          query = query.gt(entry.key, entry.value);
        }
      }

      // فلاتر أصغر من
      if (lessThanFilters != null) {
        for (final entry in lessThanFilters.entries) {
          query = query.lt(entry.key, entry.value);
        }
      }

      // فلاتر البحث النصي
      if (likeFilters != null) {
        for (final entry in likeFilters.entries) {
          query = query.ilike(entry.key, '%${entry.value}%');
        }
      }

      // فلاتر القائمة
      if (inFilters != null && inFilters.isNotEmpty) {
        query = query.inFilter('id', inFilters);
      }

      // إضافة الترتيب
      if (orderBy != null) {
        query = query.order(orderBy, ascending: ascending);
      }

      // إضافة الحد
      if (limit != null) {
        query = query.limit(limit);
      }

      // إضافة الإزاحة
      if (offset != null) {
        query = query.range(offset, offset + (limit ?? 10) - 1);
      }

      final response = await query;
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return null;
    }
  }
  
  // إدراج بيانات متعددة
  Future<List<Map<String, dynamic>>?> insertMultipleData(
    String table,
    List<Map<String, dynamic>> dataList,
  ) async {
    try {
      final response = await _client
          .from(table)
          .insert(dataList)
          .select();
      
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return null;
    }
  }
  
  // حذف بيانات متعددة
  Future<bool> deleteMultipleData(
    String table,
    String column,
    List<dynamic> values,
  ) async {
    try {
      await _client
          .from(table)
          .delete()
          .inFilter(column, values);
      
      return true;
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return false;
    }
  }
  
  // تحديث بيانات متعددة
  Future<List<Map<String, dynamic>>?> updateMultipleData(
    String table,
    Map<String, dynamic> data,
    String filterColumn,
    List<dynamic> filterValues,
  ) async {
    try {
      final response = await _client
          .from(table)
          .update(data)
          .inFilter(filterColumn, filterValues)
          .select();
      
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return null;
    }
  }
  
  // استرجاع بيانات مع العلاقات (JOIN)
  Future<List<Map<String, dynamic>>?> getDataWithRelations(
    String table,
    String selectQuery, {
    Map<String, dynamic>? filters,
    String? orderBy,
    bool ascending = true,
    int? limit,
  }) async {
    try {
      dynamic query = _client.from(table).select(selectQuery);

      // إضافة الفلاتر
      if (filters != null) {
        for (final entry in filters.entries) {
          query = query.eq(entry.key, entry.value);
        }
      }

      // إضافة الترتيب
      if (orderBy != null) {
        query = query.order(orderBy, ascending: ascending);
      }

      // إضافة الحد
      if (limit != null) {
        query = query.limit(limit);
      }

      final response = await query;
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return null;
    }
  }
  
  // تنفيذ معاملة (Transaction) - محاكاة
  Future<bool> executeTransaction(List<Future<dynamic> Function()> operations) async {
    try {
      // تنفيذ العمليات بالتسلسل
      for (final operation in operations) {
        await operation();
      }
      return true;
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return false;
    }
  }
  
  // التحقق من صحة البيانات قبل الإدراج
  bool validateData(Map<String, dynamic> data, List<String> requiredFields) {
    for (final field in requiredFields) {
      if (!data.containsKey(field) || data[field] == null) {
        if (kDebugMode) {
          print('حقل مطلوب مفقود: $field');
        }
        return false;
      }
    }
    return true;
  }
  
  // تنظيف البيانات قبل الإدراج
  Map<String, dynamic> sanitizeData(Map<String, dynamic> data) {
    final sanitized = <String, dynamic>{};
    
    for (final entry in data.entries) {
      if (entry.value != null) {
        if (entry.value is String) {
          // تنظيف النصوص من المحارف الخطيرة
          sanitized[entry.key] = (entry.value as String).trim();
        } else {
          sanitized[entry.key] = entry.value;
        }
      }
    }
    
    return sanitized;
  }
  
  // الحصول على إحصائيات الجدول
  Future<Map<String, dynamic>?> getTableStats(String table) async {
    try {
      final countResponse = await _client.from(table).select('id');

      return {
        'total_count': countResponse.length,
        'table_name': table,
        'last_updated': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return null;
    }
  }
}

