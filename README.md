# Tinted

**perfectly you**

Tinted is a personalized beauty and skincare iOS app built in SwiftUI. It helps users discover products that fit their skin profile, scan ingredients, build and track routines, and connect with beauty creators and a community feed. The app is styled as an editorial, "quiet luxury" system: flat surfaces, hairline borders, condensed caps type, and a single restrained accent color.

Beauty apps often feel generic. A product that works perfectly for one person can fail completely for another because of skin type, skin tone, ingredients, routine conflicts, or personal goals. Tinted is built to make that process personal instead of a guessing game, by grounding discovery, scanning, reviews, and routine-building in an actual skin profile.

## Status

In progress. Actively improving UI, user flow, personalization logic, and product experience.

## Architecture

The data layer is built around three formal models with real referential integrity between products and brands, verified programmatically rather than assumed.

Five tabs share a single `AppStore`, an `ObservableObject` that every tab reads from and writes to. An action in one tab is reflected in another in the same session (a like in Feed appears in Me > Likes, a save in Discover appears on the Shelf).

### Data Models

| Model | Key Fields | Notes |
|---|---|---|
| Product | id, name, brandId, category, price, rating, fitScore, isRoutineSafe, keyNotes | 102 products in the catalog. `category` is a real enum (`.makeup` / `.skincare`), not a string. |
| Brand | id, name, description, foundedYear, topProductIds | 43 brands. Every product's `brandId` resolves to a real brand, checked, not assumed. |
| Ingredient | id, name, type, shortDescription, fullDescription, isCaution, commonUses | 50 ingredients, split between everyday actives and caution-flagged ones (retinol, salicylic acid, fragrance, etc.), used to generate per-product warnings. |
| AppStore | saved/owned product IDs, written reviews, community threads, follow items, followers/following | The single shared store every tab reads and writes. This is what makes the app feel connected rather than five separate screens. |

### Component System

No screen hand-codes its own product tile, filter pill, tag, or feed post. Every instance calls one of nine shared components, parameterized by variant:

- **ProductCard** — the shared product tile, used in the Discover grid, Matched for you, and Brand top products
- **CategoryImagePlaceholder** — sparkle icon plus centered category label, standing in for a product photo everywhere one is needed
- **FilterPill** — one chip component behind both Discover's category filters and Feed's filters
- **TagChip** — rectangular badge, with a green "fit" variant and a gray "safe"/"category" variant
- **RatingRow** — star, rating, and review count, with price right-aligned
- **FitScoreBar** — large numeral, routine-safe indicator, flat progress bar, reused for both product fit and Home's skin-weather score
- **IngredientOfWeekCard** — letter tile, name, and description for the ingredient spotlight
- **FeedPostCard** — one post component with three variants (card, list, banner), replacing six earlier one-off structs
- **TrendingListItem** — ranked row for the Trending leaderboard, with rank badge, source, following badge, and like count

## Navigation

The app opens behind a short branded launch screen, then into onboarding (first run) or straight to Home.

### Onboarding

- 5-step flow: welcome, skin type selection, skin concerns selection, ingredients/products to avoid, and beauty goal selection
- Progress bar and animated transitions
- Onboarding status is saved to device so the flow only appears once

### Tab 1: Home

- Custom wordmark and tagline in place of a system nav-bar title, using condensed display type
- Product of the week, rotating once per app launch and weighted toward strong-fit, routine-safe products
- Skin Weather card built from device location plus a UV/humidity index, shown as an oversized condensed score numeral against a flat two-tone progress bar
- Matched for you: horizontally scrolling picks with a "View all" grid
- Interactive Today's routine checklist with tap-to-complete steps
- Weekly skin tip card that opens a detail sheet
- Live now banner linking to creator sessions

### Tab 2: Discover

- Search bar filtering products by name and brand
- Four category filters: All, Makeup, Skincare, For You (For You surfaces routine-safe products with a fit score of 85+, a genuinely narrower list rather than a relabeled All)
- Trending now rail, ranked by review count, shown above the main grid when All is selected
- Ingredient of the week card linking to a full ingredient page
- 2-column product grid with fit scores
- Filter sheet to sort by rating, price, or fit score, and to toggle routine-safe-only

### Tab 3: Feed

- One continuous feed, not a hard tab split, narrowed by four filter chips: All, Community, Following, Trending
- Community threads and Following posts merge into a shared list
- Each filter renders through the same FeedPostCard component in a different variant: bordered card for All, dense list row for Community, colored-header banner card for Following, plus a numbered TrendingListItem leaderboard for Trending
- Every post opens to a detail page with a live comment thread; replies persist on the model rather than on-screen state, so they survive navigating away and back

### Tab 4: Scan

- **Ingredient scanner**: barcode, label-photo, pasted-ingredient-list, and product-name search entry points, each resolving to a real catalog product
- Result screen computes an actual fit score, a "why it fits" ingredient list, and a routine-safety warning naming the specific flagged ingredient, all derived from that product's real data
- Ingredient results sheet, fit score bar, ingredient breakdown, and recent scans list
- **Skin-tone scanner**: camera or upload option, returning a tone/undertone read plus matching makeup products
- **Compare tool**: pick any two catalog products and view fit score, price, and rating side by side

### Tab 5: Me

A full profile, not a settings shortcut.

- Header with avatar, name, bio, "member since," and a gear icon into Settings
- Stat row: Posts, Followers, Following, Likes. Followers and Following are tappable into a real list with a native segmented control, follow/unfollow toggles, and tap-through to a public profile
- Achievements row computed from real state, unlocking based on actual review, post, and shelf counts rather than decoratively
- Four tabs: Posts (reviews written plus threads started), Shelf (a photo grid of saved/owned products pulling live from the shared store), Routine (links to the full Routine page), Likes (posts liked in Feed)
