import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hue/core/services/logger_service.dart';

class ResourceManager {
  final LoggerService _logger = LoggerService();
  final Map<String, Completer<dynamic>> _resourceCompleters = {};
  final Map<String, Timer> _resourceTimers = {};
  final Map<String, dynamic> _resources = {};
  
  // الحصول على مورد مع التأكد من تحميله مرة واحدة فقط
  Future<T> getResource<T>(String key, Future<T> Function() loader, {
    Duration? timeout,
    Duration? expiry,
  }) async {
    // إذا كان المورد موجود بالفعل، أرجعه
    if (_resources.containsKey(key)) {
      return _resources[key] as T;
    }
    
    // إذا كان هناك عملية تحميل جارية، انتظر اكتمالها
    if (_resourceCompleters.containsKey(key)) {
      return await _resourceCompleters[key]!.future as T;
    }
    
    // إنشاء completer جديد لتتبع عملية التحميل
    final completer = Completer<T>();
    _resourceCompleters[key] = completer;
    
    // إعداد مؤقت للمهلة إذا تم تحديده
    Timer? timeoutTimer;
    if (timeout != null) {
      timeoutTimer = Timer(timeout, () {
        if (!completer.isCompleted) {
          _logger.logError('تجاوز الوقت المحدد لتحميل المورد: $key', 'Timeout');
          completer.completeError('تجاوز الوقت المحدد لتحميل المورد');
          _resourceCompleters.remove(key);
        }
      });
    }
    
    try {
      // تحميل المورد
      final resource = await loader();
      
      // تخزين المورد
      _resources[key] = resource;
      
      // إعداد مؤقت لانتهاء صلاحية المورد إذا تم تحديده
      if (expiry != null) {
        _resourceTimers[key]?.cancel();
        _resourceTimers[key] = Timer(expiry, () {
          _resources.remove(key);
          _resourceTimers.remove(key);
        });
      }
      
      // إكمال العملية
      if (!completer.isCompleted) {
        completer.complete(resource);
      }
      
      return resource;
    } catch (e, stackTrace) {
      // تسجيل الخطأ
      _logger.logError('فشل في تحميل المورد: $key', e, stackTrace: stackTrace);
      
      // إكمال العملية بخطأ
      if (!completer.isCompleted) {
        completer.completeError(e, stackTrace);
      }
      
      rethrow;
    } finally {
      // إلغاء مؤقت المهلة
      timeoutTimer?.cancel();
      
      // إزالة المكمل من القائمة
      _resourceCompleters.remove(key);
    }
  }
  
  // إزالة مورد من الذاكرة
  void invalidateResource(String key) {
    _resources.remove(key);
    _resourceTimers[key]?.cancel();
    _resourceTimers.remove(key);
  }
  
  // إزالة جميع الموارد من الذاكرة
  void clearResources() {
    _resources.clear();
    for (final timer in _resourceTimers.values) {
      timer.cancel();
    }
    _resourceTimers.clear();
  }
  
  // التحقق من وجود مورد
  bool hasResource(String key) {
    return _resources.containsKey(key);
  }
}

// امتداد لـ Completer للتحقق من حالة الإكمال
extension CompleterExtension<T> on Completer<T> {
  bool get isCompleted => future.isDone;
}

// امتداد لـ Future للتحقق من اكتمال المستقبل
extension FutureExtension<T> on Future<T> {
  bool get isDone {
    bool isDone = false;
    bool hasError = false;
    
    scheduleMicrotask(() {
      isDone = true;
    });
    
    this.catchError((e) {
      hasError = true;
      return null as T;
    });
    
    return isDone || hasError;
  }
}

