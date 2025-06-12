import 'package:flutter/material.dart';

class LazyListView<T> extends StatefulWidget {
  final Future<List<T>> Function(int page, int limit) fetchData;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? emptyWidget;
  final int itemsPerPage;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  const LazyListView({
    Key? key,
    required this.fetchData,
    required this.itemBuilder,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
    this.itemsPerPage = 20,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
  }) : super(key: key);

  @override
  State<LazyListView<T>> createState() => _LazyListViewState<T>();
}

class _LazyListViewState<T> extends State<LazyListView<T>> {
  final List<T> _items = [];
  bool _isLoading = false;
  bool _hasError = false;
  bool _hasMoreItems = true;
  int _currentPage = 1;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        if (!_isLoading && _hasMoreItems) {
          _loadMoreData();
        }
      }
    });
  }

  Future<void> _loadData() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final newItems = await widget.fetchData(1, widget.itemsPerPage);
      
      setState(() {
        _items.clear();
        _items.addAll(newItems);
        _isLoading = false;
        _currentPage = 1;
        _hasMoreItems = newItems.length >= widget.itemsPerPage;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  Future<void> _loadMoreData() async {
    if (_isLoading || !_hasMoreItems) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final nextPage = _currentPage + 1;
      final newItems = await widget.fetchData(nextPage, widget.itemsPerPage);
      
      setState(() {
        _items.addAll(newItems);
        _isLoading = false;
        _currentPage = nextPage;
        _hasMoreItems = newItems.length >= widget.itemsPerPage;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError && _items.isEmpty) {
      return widget.errorWidget ?? 
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              const Text('حدث خطأ أثناء تحميل البيانات'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadData,
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        );
    }

    if (_items.isEmpty && !_isLoading) {
      return widget.emptyWidget ?? 
        const Center(
          child: Text('لا توجد بيانات'),
        );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        controller: _scrollController,
        shrinkWrap: widget.shrinkWrap,
        physics: widget.physics,
        padding: widget.padding,
        itemCount: _items.length + (_hasMoreItems ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _items.length) {
            return widget.itemBuilder(context, _items[index]);
          } else {
            return widget.loadingWidget ?? 
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}