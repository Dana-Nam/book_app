import 'package:flutter/material.dart';

import '../models/book_status.dart';

final statuses = [
  BookStatus(
    id: 'on_shelf',
    title: 'On Shelf',
    icon: Icons.local_library_outlined,
  ),
  BookStatus(
    id: 'in_process',
    title: 'Reading',
    icon: Icons.chrome_reader_mode_outlined,
  ),
  BookStatus(
    id: 'completed',
    title: 'Completed',
    icon: Icons.check_box,
  ),
  BookStatus(
    id: 'await',
    title: 'Await',
    icon: Icons.access_time_outlined,
  ),
];
