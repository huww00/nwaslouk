# Nwaslouk UI/UX Design Specifications

## Overview
This document outlines the comprehensive UI/UX design specifications for Nwaslouk's post-authentication experience, focusing on the passenger journey with cultural considerations for the Tunisian market.

## Design Philosophy

### Core Principles
1. **Simplicity First**: Clean, uncluttered interface that prioritizes essential actions
2. **Cultural Sensitivity**: Respects Tunisian cultural norms and local transportation habits
3. **Accessibility**: Designed for users of all technical skill levels
4. **Mobile-First**: Optimized for smartphone usage in various lighting conditions
5. **Trust & Safety**: Visual cues that emphasize security and reliability

### Visual Identity
- **Primary Color**: #E53E3E (Red) - Represents energy, movement, and urgency
- **Secondary Colors**: 
  - Blue (#4285F4) for location/GPS elements
  - Green (#10B981) for success states
  - Gray scale (#2D3748, #718096, #F7FAFC) for hierarchy
- **Typography**: System fonts with Arabic support
- **Iconography**: Material Design icons with custom louage-specific icons

## User Flow Architecture

### Primary User Journey (Passenger)
```
Authentication Success → Home/Map View → Destination Search → 
Louage Selection → Booking Confirmation → Trip Tracking
```

### Secondary Flows
- Profile Management
- Trip History
- Saved Locations
- Payment Methods
- Support & Help

## Screen Specifications

### 1. Home/Map View (`HomePage`)

#### Layout Structure
- **Full-screen map background** with mock street layout
- **Floating UI elements** overlaid on map
- **Safe area considerations** for various device sizes

#### Key Components

##### Header Section
- **Left**: Hamburger menu (48x48px circular button)
- **Center**: "نوصلوك" app title in Arabic
- **Right**: Profile avatar/button (48x48px circular)
- **Background**: White with subtle shadow
- **Spacing**: 16px horizontal margins

##### Destination Search Bar
- **Position**: Below header with 16px margin
- **Design**: Rounded rectangle (28px border radius)
- **Content**: 
  - Search icon (32x32px circular background)
  - "Where to?" placeholder text
  - Schedule icon on right
- **Interaction**: Taps open location selection overlay
- **Shadow**: Subtle drop shadow for depth

##### Map Interface
- **Mock Implementation**: Custom painted street grid
- **Current Location**: Blue dot with pulsing animation
- **Louage Markers**: 
  - White containers with red borders
  - Car icon + available seats number
  - Tap to show details modal
- **Visual Hierarchy**: Markers stand out against muted map

##### Quick Actions Panel
- **Position**: Bottom area when no overlays active
- **Content**:
  - "Quick Actions" header with lightning icon
  - 3-column grid: Home, Work, Nearby
  - "Use Current Location" button
- **Design**: White card with rounded corners (20px)

##### Bottom Navigation
- **Layout**: Split design
  - Left: "Louage Types" button (expanded)
  - Right: 4 navigation icons (Home, Trips, Wallet, Profile)
- **Active State**: Red color for current section
- **Background**: White with top shadow

#### Responsive Considerations
- **Small screens**: Reduce padding, smaller text
- **Large screens**: Maintain proportions, don't stretch
- **Landscape**: Adjust header height, reposition panels

#### Accessibility Features
- **High contrast**: Sufficient color contrast ratios
- **Touch targets**: Minimum 44x44px for all interactive elements
- **Screen reader**: Proper semantic labels
- **Keyboard navigation**: Focus indicators

### 2. Location Selection Overlay (`RecentLocationsSection`)

#### Design Pattern
- **Full-screen overlay** replacing map view
- **Slide-in animation** from right
- **White background** with structured content

#### Content Sections
1. **Header**: Back button + "Choose Destination" title
2. **Search Bar**: Text input with search icon
3. **Current Location**: GPS option with blue icon
4. **Saved Places**: Home/Work with add buttons
5. **Recent Searches**: History with clock icons
6. **Popular Destinations**: Curated list for Tunisia

#### Tunisian Context
- **Popular destinations** include:
  - Tunis Airport
  - Sidi Bou Said
  - Major universities
  - Shopping centers
  - Tourist attractions
- **Arabic place names** with French alternatives
- **Local landmarks** as reference points

### 3. Louage Type Selection (`LouageTypeSelector`)

#### Modal Design
- **Bottom sheet** covering 60% of screen
- **Handle bar** for drag-to-dismiss
- **Scrollable content** for multiple options

#### Louage Categories
1. **Standard** (3-5 TND)
   - 8-9 passengers
   - Basic comfort
   - Blue color scheme

2. **Comfort** (6-8 TND)
   - 6-7 passengers
   - Air conditioning
   - Red color scheme

3. **Express** (8-12 TND)
   - 4-5 passengers
   - Fewer stops
   - Green color scheme

4. **Intercity** (15-25 TND)
   - 8-12 passengers
   - Long distance
   - Purple color scheme

#### Card Design
- **Icon + Title + Price** layout
- **Description text** explaining service
- **Info chips** for capacity and availability
- **Tap interaction** for selection

## Cultural Considerations

### Tunisian Market Specifics
1. **Language Support**:
   - Primary: Arabic (right-to-left support)
   - Secondary: French
   - UI elements adapt to text direction

2. **Local Transportation Habits**:
   - Familiar louage terminology
   - Route-based thinking vs. point-to-point
   - Cash-first payment culture

3. **Social Norms**:
   - Gender considerations for seating
   - Family travel patterns
   - Religious observance (prayer times)

4. **Geographic Context**:
   - City-specific popular destinations
   - Intercity route awareness
   - Landmark-based navigation

## Technical Implementation Notes

### Flutter-Specific Considerations
1. **State Management**: Riverpod for reactive UI updates
2. **Navigation**: Named routes with proper back stack
3. **Animations**: Hero transitions, slide animations
4. **Platform Integration**: Location services, maps API
5. **Offline Support**: Cached locations, graceful degradation

### Performance Optimizations
1. **Lazy Loading**: Location lists, map markers
2. **Image Optimization**: SVG icons, compressed assets
3. **Memory Management**: Dispose controllers, limit map markers
4. **Network Efficiency**: Debounced search, cached responses

## Future Enhancements

### Phase 2 Features
1. **Real-time Tracking**: Live louage positions
2. **Driver Interface**: Separate UI for drivers
3. **Payment Integration**: Mobile money, cards
4. **Rating System**: User feedback mechanism
5. **Push Notifications**: Trip updates, promotions

### Advanced Features
1. **Route Optimization**: AI-powered suggestions
2. **Social Features**: Shared rides with friends
3. **Loyalty Program**: Points and rewards
4. **Multi-modal Transport**: Integration with other transport

## Testing Strategy

### User Testing Priorities
1. **Navigation Flow**: Can users complete booking flow?
2. **Cultural Appropriateness**: Do locals understand the interface?
3. **Accessibility**: Works for users with disabilities?
4. **Performance**: Smooth on low-end devices?

### A/B Testing Opportunities
1. **Search Bar Placement**: Top vs. bottom
2. **Louage Type Display**: Cards vs. list
3. **Color Schemes**: Red vs. blue primary
4. **Language Switching**: Automatic vs. manual

This design specification provides a comprehensive foundation for implementing Nwaslouk's passenger experience, balancing modern UI patterns with local cultural needs and technical constraints.