import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:mind_map_demo/utils.dart';

const showSnackBar = false;
const expandChildrenOnReady = true;
int nodeCounter = 0;

void main() {
  runApp(const Tree());
}

class Tree extends StatelessWidget {
  const Tree({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Animated Tree Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Simple Animated Tree Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  TreeViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: sampleTree.expansionNotifier,
        builder: (context, isExpanded, _) {
          return FloatingActionButton.extended(
            onPressed: () {
              if (sampleTree.isExpanded) {
                _controller?.collapseNode(sampleTree);
              } else {
                _controller?.expandAllChildren(sampleTree);
              }
            },
            label: isExpanded
                ? const Text("Collapse all")
                : const Text("Expand all"),
          );
        },
      ),
      body: TreeView.simple(
        tree: sampleTree,
        showRootNode: true,
        expansionIndicatorBuilder: (context, node) =>
            ChevronIndicator.rightDown(
              tree: node,
              color: Colors.blue[700],
              padding: const EdgeInsets.all(8),
            ),
        indentation: const Indentation(style: IndentStyle.squareJoint),
        onItemTap: (item) {
          if (kDebugMode) print("Item tapped: ${item.key}");

          if (showSnackBar) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Item tapped: ${item.key}"),
                duration: const Duration(milliseconds: 750),
              ),
            );
          }
        },
        onTreeReady: (controller) {
          _controller = controller;
          if (expandChildrenOnReady) controller.expandAllChildren(sampleTree);
        },
        builder: (context, node) => Card(
          color: colorMapper[node.level.clamp(0, colorMapper.length - 1)]!,
          child: ListTile(
            title: Text("Item ${node.level}-${node.key}"),
            subtitle: Text('Level ${node.level}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    String newKey = 'Node ${nodeCounter}';
                    node.add(TreeNode(data: 5, key: newKey));
                    print(node.childrenAsList.last);
                    nodeCounter++;
                  },
                ),
                IconButton(
                    onPressed: () {
                      node.delete();
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final sampleTree = TreeNode.root();
// ..addAll([
//   TreeNode(key: "0A")..add(TreeNode(key: "0A1A")),
//   TreeNode(key: "0C")
//     ..addAll([
//       TreeNode(key: "0C1A"),
//       TreeNode(key: "0C1B"),
//       TreeNode(key: "0C1C")
//         ..addAll([
//           TreeNode(key: "0C1C2A")
//             ..addAll([
//               TreeNode(key: "0C1C2A3A"),
//               TreeNode(key: "0C1C2A3B"),
//               TreeNode(key: "0C1C2A3C"),
//             ]),
//         ]),
//     ]),
//   TreeNode(key: "0D"),
//   TreeNode(key: "0E"),
// ]);
