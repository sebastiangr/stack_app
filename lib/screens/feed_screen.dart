import 'package:flutter/material.dart';
import '../models/card_data.dart';
import '../models/post_data.dart';
import '../widgets/horizontal_card_item.dart';
import '../widgets/post_item.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedIndex = 0; // For BottomNavigationBar

  // --- Sample Data ---
  final List<CardData> sampleCards = [
    CardData(
      id: '1',
      imageUrl: 'https://picsum.photos/seed/marketing/300/200',
      category: 'Al día en Marketing, Tende...',
      title: 'Amazon compra desde las fotos de tu carrete y lo que Gen Alpha ya decide ...',
      status: 'Nuevo • Escucha 5m',
      backgroundColor: Colors.brown.shade800, // Approximated color
      isAudio: true,
    ),
    CardData(
      id: '2',
      imageUrl: 'https://picsum.photos/seed/substack/300/200',
      category: 'The Substack Post',
      title: '"How much of my reality has been distorted for all of these years?"',
      status: '9% leído',
      backgroundColor: Colors.indigo.shade800, // Approximated color
    ),
    CardData(
      id: '3',
      imageUrl: 'https://picsum.photos/seed/tech/300/200',
      category: 'Technology Weekly',
      title: 'The Rise of AI in Everyday Apps',
      status: 'Nuevo',
       backgroundColor: Colors.teal.shade800,
    ),
  ];

  // Use late initialization for posts list to manage state
  late List<PostData> samplePosts;

  @override
  void initState() {
    super.initState();
    // Initialize the list here so it persists across builds
    samplePosts = [
       PostData(
          id: 'p1',
          userAvatarUrl: 'https://picsum.photos/seed/barbara/100/100',
          userName: 'Bárbara Duhau',
          channelName: 'Belleza que salva por Bárbara Duhau • 1 días',
          content:
              'La mitad del acto creativo es sentarte y hacer.\nEl resto es suerte, talento, ganas, ideas, corazón, esfuerzo. Pero el 50% siempre es atravesar la incomodidad de empezar.\n\nCreo que las únicas personas que se dedican al arte o la creatividad que son verdaderamente exitosas son las que descubren que no hay ningún secreto más que atravesar la incomodidad que supone ponerse a crear.',
          likes: 234,
          comments: 11,
          reposts: 31,
        ),
        PostData(
          id: 'p2',
          userAvatarUrl: 'https://picsum.photos/seed/maria/100/100',
          userName: 'María De Bordas',
          channelName: 'María\'s Substack • 3w',
          content:
              'Una chica subió fotos de sus páginas escritas, mostrando la vulnerabilidad del proceso creativo.',
          likes: 155,
          comments: 23,
          reposts: 8,
        ),
        PostData(
          id: 'p3',
          userAvatarUrl: 'https://picsum.photos/seed/juan/100/100',
          userName: 'Juan Pérez',
          channelName: 'Reflexiones • 2h',
          content: 'Explorando nuevas ideas para el próximo proyecto. El café ayuda.',
          likes: 42,
          comments: 5,
          reposts: 2,
        ),
    ];
  }
 // --- End Sample Data ---

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Handle navigation logic here if needed
      print("Tapped item: $index");
    });
  }

  void _deletePost(String postId) {
     setState(() {
       samplePosts.removeWhere((post) => post.id == postId);
       print("Deleted post: $postId");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Post eliminado"),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2),
          ),
        );
     });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background
      // 1. Header Superior Fijo
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F), // Slightly lighter than bg
        elevation: 0, // No shadow
        leadingWidth: 80, // Give more space for the logo
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: Container( // Placeholder for Logo
              width: 40,
              height: 30,
              decoration: BoxDecoration(
                 color: Colors.orange, // Original logo color
                 borderRadius: BorderRadius.circular(4)
              ),
               child: const Center(child: Text(" K ", style: TextStyle(color: Color(0xFF1F1F1F), fontWeight: FontWeight.bold))), // Simple representation
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 28.0, color: Colors.white70),
            onPressed: () {
              print("Search tapped");
            },
            tooltip: 'Buscar',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CircleAvatar(
              radius: 16.0,
              backgroundImage: const NetworkImage('https://picsum.photos/seed/user/100/100'), // Placeholder user icon
              backgroundColor: Colors.grey[700],
            ),
          ),
        ],
      ),

      // Contenedor Principal Scrolleable
      body: CustomScrollView(
        slivers: [
          // Top navigation chips (Home, Following, etc.) - Simplified version
          SliverToBoxAdapter(
             child: Container(
               height: 50, // Height for the chips row
               padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
               child: ListView(
                 scrollDirection: Axis.horizontal,
                 children: [
                    _buildFilterChip("Home", isSelected: true),
                    _buildFilterChip("Following"),
                    _buildFilterChip("New Bestsellers"),
                    _buildFilterChip("Technology"),
                    _buildFilterChip("Culture"), // Added one more
                 ],
               ),
             ),
          ),

          // 2. Horizontal Card List
          SliverToBoxAdapter(
            child: Container(
              height: 240.0, // Adjust height as needed for cards
              padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 20.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sampleCards.length,
                itemBuilder: (context, index) {
                  return HorizontalCardItem(cardData: sampleCards[index]);
                },
              ),
            ),
          ),

          // 3. Vertical Post List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final post = samplePosts[index];
                return Dismissible(
                  key: Key(post.id), // Unique key for Dismissible
                  direction: DismissDirection.endToStart, // Swipe left to delete
                  onDismissed: (direction) {
                    _deletePost(post.id);
                  },
                   background: Container(
                     color: Colors.redAccent,
                     padding: const EdgeInsets.only(right: 20.0),
                     alignment: Alignment.centerRight,
                     child: const Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                          Text("Borrar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          SizedBox(width: 8),
                         Icon(Icons.delete_outline, color: Colors.white),
                       ],
                     ),
                   ),
                  child: Column(
                    children: [
                       // Adding the "Liked by..." text if applicable (like in screenshot)
                       if (index == 0) // Example: Show only for the first post
                         Padding(
                            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, top: 10.0),
                            child: Row(
                               children: [
                                  Icon(Icons.favorite, color: Colors.grey[600], size: 16),
                                  const SizedBox(width: 8),
                                  Text("Vanessa Marin Marrero liked", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                               ],
                            ),
                         ),
                       PostItem(
                        postData: post,
                        onLike: () => print("Like ${post.id}"),
                        onComment: () => print("Comment ${post.id}"),
                        onRepost: () => print("Repost ${post.id}"),
                        onShare: () => print("Share ${post.id}"),
                        onSubscribe: () => print("Subscribe to ${post.userName}"),
                        onMenu: () => print("Menu for ${post.id}"),
                      ),
                      if (index < samplePosts.length -1) // Add divider except for last item
                         Divider(height: 1, thickness: 1, color: Colors.grey[850]), // Subtle divider
                    ],
                  ),
                );
              },
              childCount: samplePosts.length,
            ),
          ),
            // Add some padding at the bottom of the scroll view so FAB doesn't overlap last item too much
           const SliverToBoxAdapter(
             child: SizedBox(height: 80),
           )
        ],
      ),

      // 5. Botón Flotante "+"
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Add new entry");
        },
        backgroundColor: Colors.orange, // Color from image
        child: const Icon(Icons.add, color: Colors.white, size: 30.0),
        shape: const CircleBorder(), // Make it perfectly round
      ),
      // Adjust FAB position if needed, endFloat is common
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,


      // 4. Barra de Menú Inferior Fija
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled), // Using filled for selected
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.orange,
            icon: Icon(
              Icons.play_circle_outline,
              color: Colors.white,
              size: 40.0,
            ),
            label: 'Play',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Mensajes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined), // Notifications icon
            label: 'Notificaciones',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // Styling for dark theme
        backgroundColor: const Color(0xFF1F1F1F), // Match AppBar color
        type: BottomNavigationBarType.fixed, // Shows all labels
        selectedItemColor: Colors.white, // Color for selected icon/label
        unselectedItemColor: Colors.white54, // Color for unselected
        selectedFontSize: 12.0, // Adjust font size
        unselectedFontSize: 12.0,
        showSelectedLabels: false, // Hide labels as per screenshot style
        showUnselectedLabels: false,
      ),
    );
  }

 // Helper for filter chips like 'Home', 'Following'
 Widget _buildFilterChip(String label, {bool isSelected = false}) {
   return Padding(
     padding: const EdgeInsets.symmetric(horizontal: 4.0),
     child: ChoiceChip(
       label: Text(label),
       selected: isSelected,
       onSelected: (selected) {
         // Handle chip selection logic here
         print("$label tapped");
       },
       backgroundColor: Colors.grey[800], // Unselected chip background
       selectedColor: Colors.white, // Selected chip background
       labelStyle: TextStyle(
         color: isSelected ? Colors.black : Colors.white70, // Text color
         fontSize: 14,
         fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
       ),
       padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(20.0),
         side: BorderSide(color: Colors.transparent), // No border
       ),
     ),
   );
 }
}