import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:stack_app/widgets/botton_navigation.dart';
import 'package:stack_app/widgets/custom_drawer.dart';
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
  // 1. Añade una GlobalKey para el Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          // 2. Asigna la key al Scaffold
      key: _scaffoldKey,
      // backgroundColor: const Color(0xFF121212), // Dark background
      
      // 1. Header Superior Fijo
      appBar: AppBar(
        // El backgroundColor y otros estilos vienen del tema
        // Reemplaza el leading por un IconButton para abrir el Drawer
        leading: IconButton(
          icon: const Icon(LucideIcons.menu), // Icono de menú
          tooltip: 'Abrir menú',
          onPressed: () {
            // Abre el Drawer usando la GlobalKey
            _scaffoldKey.currentState?.openDrawer();
          },
          // El color del icono se toma del AppBarTheme
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.search), // Usa Lucide
            onPressed: () {
              print("Search tapped");
            },
            tooltip: 'Buscar',
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // Ajusta el padding si es necesario
            child: GestureDetector(
              onTap: () {
                  // Acción al tocar el avatar (quizás abrir perfil o el mismo drawer)
                  _scaffoldKey.currentState?.openDrawer();
                  print("User Avatar tapped");
              },
              child: const CircleAvatar(
                radius: 16.0,
                backgroundImage: NetworkImage('https://picsum.photos/seed/user/100/100'),
                backgroundColor: Colors.grey,
              ),
            ),
          ),
        ],
      ),

      // 4. Añade el Drawer al Scaffold
      drawer: const CustomDrawer(),

      // Contenedor Principal Scrolleable
      body: CustomScrollView(
        slivers: [
          // Top navigation chips (Home, Following, etc.) - Simplified version
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).appBarTheme.backgroundColor, // O un color ligeramente diferente
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
                  // Aquí podrías necesitar ajustar el color de fondo de HorizontalCardItem
                  // si no está usando colores del tema automáticamente.
                  // O pasarle el themeProvider.isDarkMode si necesita lógica interna.
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
                  key: Key(post.id),
                  direction: DismissDirection.endToStart,
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
                        Icon(LucideIcons.trash, color: Colors.white), // Puedes cambiar a LucideIcons.trash2
                      ],
                    ),
                  ),
                  // Envuelve en un Container para dar margen/padding si es necesario
                  // y para asegurar que el color de fondo sea el correcto
                  child: Container(
                    // color: Theme.of(context).cardTheme.color ?? Theme.of(context).colorScheme.surface,
                    // color: Theme.of(context).scaffoldBackgroundColor, // Color de fondo del Scaffold
                    margin: const EdgeInsets.symmetric(vertical: 4), // Espacio entre posts
                    child: Column(
                    
                      children: [
                        // "Liked by..." text (Ajusta estilo según tema)
                        if (index == 0)
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, top: 10.0),
                            child: Row(
                              children: [
                                Icon(LucideIcons.heart, // Usa Lucide
                                  color: Colors.grey[600],
                                  size: 16),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Vanessa Marin Marrero liked",
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7) ?? Colors.grey[600],
                                      fontSize: 13
                                    )
                                  ),
                                ],
                            ),
                          ),
                          PostItem( // Asegúrate que PostItem use colores del tema o recíbelos
                            postData: post,
                            onLike: () => print("Like ${post.id}"),
                            onComment: () => print("Comment ${post.id}"),
                            onRepost: () => print("Repost ${post.id}"),
                            onShare: () => print("Share ${post.id}"),
                            onSubscribe: () => print("Subscribe to ${post.userName}"),
                            onMenu: () => print("Menu for ${post.id}"),
                          ),
                        // El Divider usará el dividerColor del tema
                        if (index < samplePosts.length -1) Divider(height: 1, thickness: 1, color: Theme.of(context).dividerColor),
                      ],
                    ),
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
      // TODO: Verificar si es necesario
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     print("Add new entry");
      //   },
      //   backgroundColor: Colors.orange, // Color from image
      //   child: const Icon(Icons.add, color: Colors.white, size: 30.0),
      //   shape: const CircleBorder(), // Make it perfectly round
      // ),
      // Adjust FAB position if needed, endFloat is common
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,


      // 4. Barra de Menú Inferior Fija
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),      
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home_filled), // Using filled for selected
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.dashboard_outlined),
      //       label: 'Dashboard',
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Colors.orange,
      //       icon: Icon(
      //         Icons.play_circle_outline,
      //         color: Colors.white,
      //         size: 40.0,
      //       ),
      //       label: 'Play',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.chat_bubble_outline),
      //       label: 'Mensajes',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications_none_outlined), // Notifications icon
      //       label: 'Notificaciones',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   // Styling for dark theme
      //   backgroundColor: const Color(0xFF1F1F1F), // Match AppBar color
      //   type: BottomNavigationBarType.fixed, // Shows all labels
      //   selectedItemColor: Colors.white, // Color for selected icon/label
      //   unselectedItemColor: Colors.white54, // Color for unselected
      //   selectedFontSize: 12.0, // Adjust font size
      //   unselectedFontSize: 12.0,
      //   showSelectedLabels: false, // Hide labels as per screenshot style
      //   showUnselectedLabels: false,
      // ),
    );
  }

 // Helper for filter chips like 'Home', 'Following'
  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    final theme = Theme.of(context);
    final chipBackgroundColor = theme.brightness == Brightness.dark ? Colors.grey[800] : Colors.grey[300];
    final selectedChipColor = theme.brightness == Brightness.dark ? Colors.white : Colors.black;
    final chipTextColor = theme.brightness == Brightness.dark ? Colors.white70 : Colors.black87;
    final selectedChipTextColor = theme.brightness == Brightness.dark ? Colors.black : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          print("<Button action> log: $label tapped");
        },
        backgroundColor: chipBackgroundColor,
        selectedColor: selectedChipColor,
        labelStyle: TextStyle(
          color: isSelected ? selectedChipTextColor : chipTextColor,
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
        padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.transparent),
        ),
       // Añadir un poco de elevación o borde si se ve muy plano
        elevation: isSelected ? 1 : 0,
      ),
    );
  }
}