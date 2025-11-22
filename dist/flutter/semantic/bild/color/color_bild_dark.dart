
//
// color_bild_dark.dart
//

// Do not edit directly, this file was auto-generated.



import 'dart:ui';

class ColorBildDark {
    ColorBildDark._();

    /** Used as the main brand color for key interactive elements such as primary buttons, active states, and prominent highlights. It remains constant across Light and Dark Mode. */
    static const semanticCoreCorecolorprimary = Color(0xFFde0000);
    /** Defines the secondary brand tone. This variable changes across Light and Dark Mode. */
    static const semanticCoreCorecolorsecondary = Color(0xFF242629);
    /** Represents tertiary brand accents. This variable changes across Light and Dark Mode. */
    static const semanticCoreCorecolortertiary = Color(0xFFffffff);
    /** Use this on elements that must maintain the white color even in dark mode. */
    static const semanticCoreCorecolorsecondaryconstant = Color(0xFFffffff);
    /** Use this on elements that need to maintain the dark color across themes and color modes. */
    static const semanticCoreCorecolortertiaryconstant = Color(0xFF242629);
    /** this is a test for the token pipeline */
    static const semanticCoreCorecolortertiaryvvpipetest = Color(0xFFb0d1f2);
    /** this is a test for the token pipeline */
    static const semanticCoreNpmtest = Color(0xFFb0d1f2);
    /** this is a test for the token pipeline */
    static const semanticCoreFelipetestcolor = Color(0xFF031a30);
    /** Primary accent color used to emphasize interactive or highlight elements such as links, selection states, or focus indicators. Adapts in Darkmode to a fully white tone. */
    static const semanticAttentionAccentcolorprimary = Color(0xFFffffff);
    /** Used for accent highlights that must remain visually consistent across themes (e.g., brand identifiers, logos, or fixed emphasis areas). Color value does not change between Light and Dark mode. */
    static const semanticAttentionAccentcolorprimaryconstant = Color(0xFFde0000);
    /** Primary success color used to indicate positive states, confirmations, or completed actions (e.g., success banners, icons, or badges). Remains the same across modes to ensure recognizability and consistency. */
    static const semanticAttentionAttentioncolorsuccessprimary = Color(0xFF00c273);
    /** Secondary success tone used for secondary states. Maintains the same color in both Light and Dark mode for clarity. */
    static const semanticAttentionAttentioncolorsuccesssecondary = Color(0xFF006e3d);
    /** Very low-contrast background tone used for information or system-neutral surfaces, often for tooltips or quiet information highlights. Dynamic — light neutral in Light mode and dark neutral in Dark mode. */
    static const semanticAttentionAttentioncolorextralow = Color(0xFF333d40);
    /** Low-level warning or attention tone, typically used for informational or cautionary messages. Same yellow tone across Light and Dark to maintain recognition. */
    static const semanticAttentionAttentioncolorlow = Color(0xFFffbf00);
    /** Medium-level attention tone representing stronger caution or intermediate alert states. Commonly applied in warning messages. Constant — identical in both modes. */
    static const semanticAttentionAttentioncolormedium = Color(0xFFfc8226);
    /** High-level attention color used for errors, destructive actions, and critical alerts (e.g., delete actions, error states). Remains red in both Light and Dark mode for immediate recognition. */
    static const semanticAttentionAttentioncolorhigh = Color(0xFFde0000);
    /** Used for subtle dividers and low-emphasis borders in neutral areas (e.g., card outlines, input containers).
Dynamic — light gray in Light mode, dark gray in Dark mode. */
    static const semanticBorderBordercolorlowcontrast = Color(0xFF4a5259);
    /** Applies to UI elements that must visually remain the same regardless of theme (e.g., brand containers, static illustrations). Identical tone across Light and Dark mode. */
    static const semanticBorderBordercolorlowcontrastconstant = Color(0xFFe8edf0);
    /** Medium-emphasis border color for standard outlines, input fields, or separators that require visible yet non-dominant contrast.
Behavior: Dynamic — adjusts to maintain legibility in Light and Dark themes. */
    static const semanticBorderBordercolormediumcontrast = Color(0xFF666b70);
    /** High-emphasis border color for clear delineation between surfaces (e.g., focus rings, high-contrast UI zones).
Behavior: Dynamic — light surfaces use a darker neutral, dark surfaces a light neutral tone. */
    static const semanticBorderBordercolorhighcontrast = Color(0xFFffffff);
    /** Used for success states and validation borders (e.g., input success outlines or confirmation frames).
Behavior: Constant — same success tone across modes for consistent feedback semantics. */
    static const semanticBorderBordercolorsuccess = Color(0xFF00c273);
    /** Defines border color for warning and error-related components, typically used for input validation or caution zones.
Behavior: Constant — retains the same red warning tone in both Light and Dark modes. */
    static const semanticBorderBordercolorwarning = Color(0xFFde0000);
    /** Applied to disabled states of primary elements (e.g., buttons, inputs) to visually reduce emphasis and indicate inactivity. */
    static const semanticBorderBordercolorprimarydisabled = Color(0xFF333d40);
    /** Used for secondary component borders in a disabled state (e.g., secondary buttons, inactive input outlines). */
    static const semanticBorderBordercolorsecondarydisabled = Color(0xFF4a5259);
    /** Primary icon color on primary surfaces. */
    static const semanticIconIconcolorprimary = Color(0xFF8c9196);
    /** Used for icons that must remain visually consistent regardless of mode (e.g.,  icons that are on surfaces that don't change color).
Identical tone in both Light and Dark mode. */
    static const semanticIconIconcolorprimaryconstant = Color(0xFF4a5259);
    /** Inverse icon color for use on contrasting backgrounds (e.g., light icons on dark surfaces or dark icons on bright surfaces).
Behavior: Dynamic — switches between light and dark. */
    static const semanticIconIconcolorinverse = Color(0xFF4a5259);
    /** Secondary icon tone for less prominent actions or supportive iconography (e.g., secondary buttons, tool icons). Remains unchanged across modes. */
    static const semanticIconIconcolorsecondaryconstant = Color(0xFF8c9196);
    /** Used for icons displayed on dark backgrounds that don´t change colors, ensuring sufficient contrast and legibility.
Behavior: Constant — always uses a neutral bright value. */
    static const semanticIconIconcolorconstantondark = Color(0xFFf2f5f5);
    /** Represents success or confirmation icons (e.g., checkmarks, completion indicators).
Behavior: Constant — same success green tone across Light and Dark mode. */
    static const semanticIconIconcolorsuccess = Color(0xFF00c273);
    /** A semi-transparent black overlay used to dim background content when modals, drawers, or dialogs are active. Identical opacity and tone in both Light and Dark mode to ensure consistent overlay depth. */
    static const semanticOverlayOverlayscrimblack = Color(0xb3000000);
    /** A semi-transparent white overlay used to brighten or fade background layers, often applied behind bottom sheets or temporary panels.
Behavior: Constant — same opacity level across modes to preserve uniform layering behavior. */
    static const semanticOverlayOverlayscrimwhite = Color(0xb3ffffff);
    /** Used to represent the active or pressed state of primary actions such as tabs or links.
Behavior: Constant — identical value across modes for consistent interaction feedback. */
    static const semanticStateColorprimaryactive = Color(0xFFde0000);
    /** Defines the active state color for secondary actions (e.g., secondary buttons, tabs, or toggles).
Behavior: Dynamic — light gray in Light mode and bright gray in Dark mode to maintain perceptual balance. */
    static const semanticStateColorsecondaryactive = Color(0xFFf2f5f5);
    /** Inverse variant of the secondary active state, applied on dark backgrounds or inverse layouts.
Behavior: Dynamic — switches between bright and dark tones depending on the background. */
    static const semanticStateColorsecondaryactiveinverse = Color(0xFF242629);
    /** Represents active or pressed states for tertiary elements (e.g., link highlights, icons, or subtle interactive surfaces).
Behavior: Constant — uses the same green success tone across Light and Dark mode. */
    static const semanticStateColortertiaryactive = Color(0xFF00c273);
    /** Defines the disabled color for primary components (e.g., disabled primary buttons, inputs). Reduces emphasis and contrast to signal inactivity.
Behavior: Dynamic — slightly lighter in Light mode and darker in Dark mode to remain visually accessible. */
    static const semanticStateColorprimarydisabled = Color(0xFF333d40);
    /** Used for disabled secondary elements, ensuring reduced visual prominence while maintaining legibility.
Behavior: Dynamic — adapts neutral tones based on theme brightness. */
    static const semanticStateColorsecondarydisabled = Color(0xFF4a5259);
    /** Represents disabled states for tertiary levels, maintaining subtle visibility without drawing attention.
Behavior: Dynamic — adjusts between gray tones for Light and Dark mode consistency. */
    static const semanticStateColortertiarydisabled = Color(0xFF666b70);
    /** Primary surface color used for main backgrounds and large layout areas (e.g., page background, primary containers).
Behavior: Dynamic — adapts between light and dark surface tokens to maintain legibility and hierarchy. */
    static const semanticSurfaceSurfacecolorprimary = Color(0xFF242629);
    /** Inverse of the primary surface, used when Light and Dark surfaces are swapped (e.g., inverse cards or elevated sections).
Behavior: Dynamic — switches between dark and light values depending on mode. */
    static const semanticSurfaceSurfacecolorprimaryinverse = Color(0xFFffffff);
    /** A fixed light surface tone used when a consistent light background is required (e.g., light panels within dark layouts).
Behavior: Constant — remains the same in both modes. */
    static const semanticSurfaceSurfacecolorprimaryconstantlight = Color(0xFFffffff);
    /** A fixed dark surface tone used for dark overlays or nested dark sections inside light layouts.
Behavior: Constant — identical across Light and Dark mode. */
    static const semanticSurfaceSurfacecolorprimaryconstantdark = Color(0xFF242629);
    /** Used for secondary surface layers such as cards, panels, or nested containers that need to differentiate themselves from the primary surface. .
Behavior: Dynamic — adapts brightness level based on mode for appropriate depth contrast. */
    static const semanticSurfaceSurfacecolorsecondary = Color(0xFF2b3038);
    /** Tertiary background layer for inner containers, grouped content, or subtle elevation steps  that need to differentiate themselves from the primary and secondary surfaces.
Behavior: Dynamic — switches between light and dark tertiary tones. */
    static const semanticSurfaceSurfacecolortertiary = Color(0xFF333d40);
    /** Inverse tertiary background, applied when Light and Dark surfaces are reversed (e.g., dark-on-light cards).
Behavior: Dynamic — swaps values between modes for contrast preservation. */
    static const semanticSurfaceSurfacecolortertiaryinverse = Color(0xFFe8edf0);
    /** HIghtest elevation surface color, typically used for grouping or background accents to differentiate themselves from all previous surface color options. Uses corresponding light/dark tones for consistent layering. */
    static const semanticSurfaceSurfacecolorquartenary = Color(0xFF4a5259);
    /** Inverse of the quartenary surface, used for background reversals in mixed-layout areas.
Behavior: Dynamic — inverts between dark and light tones depending on mode. */
    static const semanticSurfaceSurfacecolorquartenaryinverse = Color(0xFFcfd4d9);
    /** Success-related background used for positive notifications, confirmation surfaces, or success banners.
Behavior: Constant — remains the same across Light and Dark mode to ensure brand alignment. */
    static const semanticSurfaceSurfacecolorsuccess = Color(0xFFcff5e3);
    /** Defines the end stops for primary surface gradients, creating visual depth or elevation. Used next to sliders buttons and slider container edges for fading out content. Behavior: Dynamic — light gradients in Light mode, dark gradients in Dark mode. */
    static const semanticSurfaceSurfacecolorprimarygradientstop = Color(0x00242629);
    /** Used for secondary surface gradients or subtle depth layers across backgrounds.
Behavior: Dynamic — adapts to mode brightness for smooth gradient transitions. */
    static const semanticSurfaceSurfacecolorsecondarygradientstop = Color(0x002b3038);
    /** Represents tertiary-level gradient background.
Currently used on skeletons. */
    static const semanticSurfaceSurfacecolortertiarygradientstop = Color(0x00333d40);
    /** Primary color for headings and display typography. Ensures clear hierarchy and optimal readability on main surfaces. Adapds it´s color based on the brand mode for brand recognition.
Behavior: Dynamic — dark text in Light mode, light text in Dark mode. */
    static const semanticHeadingHeadlinecolorprimary = Color(0xFFffffff);
    /** Fixed white heading color used on dark or colored backgrounds (e.g., hero sections, banners) that remain constant across modes.
Behavior: Constant — remains white in both Light and Dark mode. */
    static const semanticHeadingHeadlinecolorwhiteconst = Color(0xFFffffff);
    /** Used for kicker text and category labels placed directly on standard surface backgrounds.
Behavior: Dynamic — adjusts between red for Light and a neutral tone in Dark modes. */
    static const semanticHeadingKickertextcoloronsurface = Color(0xFF8c9196);
    /** Specialized kicker color for use on red or brand-colored backgrounds (e.g., red kicker bg within teaser cards).
Behavior: Constant — remains consistent across light and darkmode. */
    static const semanticHeadingKickertextcoloronred = Color(0xFFffffff);
    /** Applied to kicker or meta text on dark colored backgrounds to maintain high legibility.
Behavior: Constant — always uses semi-transparent white for consistent readability. */
    static const semanticHeadingKickertextcolorondarkbg = Color(0xccffffff);
    /** Used for kicker text placed on bright or light colored backgrounds. Ensures balanced contrast without harsh visual dominance.
Behavior: Constant — remains semi-transparent black across both modes. */
    static const semanticHeadingKickertextcoloronbrightbg = Color(0xb3000000);
    /** Main text color used for body copy and all primary textual content. Ensures optimal readability and contrast on standard surfaces.
Behavior: Dynamic — switches between dark text on light backgrounds and light text on dark backgrounds. */
    static const semanticTextTextcolorprimary = Color(0xFFe8edf0);
    /** Used when primary text color must remain fixed regardless of mode (e.g., on light constant backgrounds).
Behavior: Constant — same tone across Light and Dark mode. */
    static const semanticTextTextcolorprimaryconstant = Color(0xFF242629);
    /** Inverse text color used on opposing surfaces (e.g., white text on red or dark backgrounds).
Behavior: Dynamic — alternates between light and dark mode. */
    static const semanticTextTextcolorprimaryinverse = Color(0xFF242629);
    /** Fixed inverse tone for text that always appears on dark surfaces (e.g., hero headlines or persistent dark cards).
Behavior: Constant — unchanged across modes. */
    static const semanticTextTextcolorprimaryinverseconstant = Color(0xFFe8edf0);
    /** Secondary text color used for supportive information, subtitles, and less prominent text.
Behavior: Dynamic — adapts between neutral tones to maintain proper contrast per theme. In 2025 css it is called figure meta. */
    static const semanticTextTextcolorsecondary = Color(0xFF8c9196);
    /** Muted text tone for subtle information, timestamps, or inactive text elements.
Behavior: Dynamic — adjusts between mid-gray in Light mode and lighter gray in Dark mode. */
    static const semanticTextTextcolormuted = Color(0xFFcfd4d9);
    /** Used for text displayed on dark surfaces to ensure maximum legibility and contrast.
Behavior: Constant — always light neutral to guarantee accessibility on dark backgrounds. */
    static const semanticTextTextcolorondarksurface = Color(0xFFffffff);
    /** Accent text color used for links, interactive text, or highlighted key words. Changes from a red in light mode to a white in dark mode. */
    static const semanticTextTextcoloraccent = Color(0xFFffffff);
    /** Applies to text elements requiring fixed brand color usage (e.g., permanent links, brand slogans on constant backgrounds).
Behavior: Constant — maintains identical red tone across Light and Dark mode. */
    static const semanticTextTextcoloraccentconstant = Color(0xFFde0000);
    /** Used for positive or success-related messages (e.g., “Saved”, “Success”, or confirmation text) on success surface colors.
Behavior: Constant — green tone remains consistent across both modes. */
    static const semanticTextTextcolorsuccessconstant = Color(0xFF006e3d);
    /** Used for strong warnings, errors, or destructive action labels.
Behavior: Constant — red color remains unchanged between Light and Dark mode for visibility and recognition. */
    static const semanticTextTextcolorattentionhigh = Color(0xFFde0000);
    /** Represents medium attention states, often used in warnings or pending states.
Behavior: Constant — same orange tone across Light and Dark mode. */
    static const semanticTextTextcolorattentionmedium = Color(0xFFfc8226);
    /** Primary label color used for labels, badges, or tag text on light backgrounds. Ensures strong readability and visual hierarchy.
Behavior: Dynamic — dark neutral in Light mode, light neutral in Dark mode. */
    static const semanticLabelLabelcolorprimary = Color(0xFFe8edf0);
    /** Inverse version of the primary label color, used on dark or colored backgrounds.
Behavior: Dynamic — switches between light and dark. */
    static const semanticLabelLabelcolorprimaryinverse = Color(0xFF242629);
    /** Used when primary label color should remain unchanged across modes in static UI areas.
Behavior: Constant — identical tone in both Light and Dark mode. */
    static const semanticLabelLabelcolorprimaryconstant = Color(0xFF242629);
    /** Fixed inverse label tone applied where white or bright text must always appear, regardless of theme.
Behavior: Constant — remains bright neutral in both Light and Dark mode. */
    static const semanticLabelLabelcolorprimaryinverseconstant = Color(0xFFe8edf0);
    /** Secondary label tone used for less prominent text such as secondary badges or supporting labels.
Behavior: Dynamic — adapts between mid-grays for Light and Dark surfaces. */
    static const semanticLabelLabelcolorsecondary = Color(0xFFcfd4d9);
    /** Tertiary label tone for subtle, low-emphasis UI text such as placeholder text or tertiary badges.
Behavior: Constant — identical tone across both modes for stable hierarchy. */
    static const semanticLabelLabelcolortertiary = Color(0xFF8c9196);
    /** Disabled label tone indicating inactive or unavailable states in UI elements.
Behavior: Dynamic — lighter gray in Light mode, darker neutral in Dark mode. */
    static const semanticLabelLabelcolordisabled = Color(0xFF4a5259);
    static const semanticLayeropacityLayeropacity00 = 0;
    static const semanticLayeropacityLayeropacity05 = 5;
    static const semanticLayeropacityLayeropacity10 = 10;
    static const semanticLayeropacityLayeropacity20 = 20;
    static const semanticLayeropacityLayeropacity30 = 30;
    static const semanticLayeropacityLayeropacity40 = 40;
    static const semanticLayeropacityLayeropacity50 = 50;
    static const semanticLayeropacityLayeropacity60 = 60;
    static const semanticLayeropacityLayeropacity70 = 70;
    static const semanticLayeropacityLayeropacity80 = 80;
    static const semanticLayeropacityLayeropacity90 = 90;
    static const semanticLayeropacityLayeropacity100 = 100;
    /** 09-2025 css --article-author-name-color */
    static const componentAvatarAvatarlabelcolor = Color(0xFFffffff);
    /** 09-2025 css --article-author-name-color */
    static const componentAvatarAvatarlabelcolorhover = Color(0xFFde0000);
    /** On marketing offer surfaces this variable is usually not used. The alertSurfaceConstant variables should be used. This token changes color between light and dark modes. L:100 / D:025 */
    static const componentAlertAlertsurfacecolor = Color(0xFF333d40);
    /** On marketing offer surfaces this variable is  used. */
    static const componentAlertAlertsurfacecolorconstant = Color(0xFFffffff);
    /** Use this token on breadcrumbs that are in their default idle state. This token changes color between light and dark modes. L:035 / D:096 */
    static const componentBreadcrumbBreadcrumbtextcoloridle = Color(0xFFf2f5f5);
    /** Use this token on breadcrumbs that the user's pointer is hovering on or clicked on. This token changes color between light and dark modes. L:015 / D:100 */
    static const componentBreadcrumbBreadcrumbtextcolorhover = Color(0xFFffffff);
    static const componentBreakingnewsBreakingnewstoptitletextcolor = Color(0xFF1c1c1c);
    static const componentBreakingnewsBreakingnewsbottomtitletextcolor = Color(0xFF1c1c1c);
    static const componentBreakingnewsBreakingnewstitlesurfacecolor = Color(0xFFfc8226);
    static const componentBreakingnewsBreakingnewssurfacecolor = Color(0xFFe8edf0);
    static const componentBreakingnewsBreakingnewstextcontentcolor = Color(0xFF242629);
    static const componentButtonPrimaryButtonprimarylabelcolor = Color(0xFFffffff);
    /** Use this variable on the neutral color primary button. Tone changes between light and dark mode. Light mode Bild & SpoBi: Tone 015 ; Dark mode Bild & SpoBi: Tone 100 */
    static const componentButtonPrimaryButtonprimaryneutralbgcoloridle = Color(0xFFffffff);
    static const componentButtonPrimaryButtonprimaryneutralbgcolorhover = Color(0xFFe8edf0);
    static const componentButtonPrimaryButtonprimarybrandbgcoloridle = Color(0xFFde0000);
    static const componentButtonPrimaryButtonprimarybrandbgcolorhover = Color(0xFFb00003);
    static const componentButtonPrimaryButtonprimarysuccesscoloridle = Color(0xFF17995c);
    static const componentButtonPrimaryButtonprimarysuccesscolorhover = Color(0xFF006e3d);
    static const componentButtonSecondaryButtonsecondarylabelcolor = Color(0xFFe8edf0);
    static const componentButtonSecondaryButtonsecondarybgcoloridle = Color(0xFF4a5259);
    static const componentButtonSecondaryButtonsecondarybgcolorhover = Color(0x80cfd4d9);
    static const componentButtonTertiaryButtontertiarylabelcolor = Color(0xFFf2f5f5);
    static const componentButtonTertiaryButtontertiarybordercoloridle = Color(0xFF4a5259);
    static const componentButtonTertiaryButtontertiarybordercolorhover = Color(0xFFffffff);
    static const componentButtonTertiaryButtontertiarysuccessbgcolorhover = Color(0x80009c59);
    static const componentButtonTertiaryButtontertiarysuccessbordercolor = Color(0xFF17995c);
    static const componentButtonGhostButtonghostbgcolorhover = Color(0x80cfd4d9);
    static const componentButtonButtonlivetickerloadnewsurfacecolor = Color(0xFF242629);
    static const componentButtonButtonlivetickerloadnewlabelcolor = Color(0xFFf2f5f5);
    static const componentCardCardsurfacebgcolor = Color(0xFF2b3038);
    static const componentChipsChipsbgcoloridle = Color(0xFF4a5259);
    static const componentChipsChipsbgcoloractive = Color(0xFFffffff);
    static const componentChipsChipsbgcolorhover = Color(0xFFcfd4d9);
    static const componentChipsChipslabelcoloridle = Color(0xFFffffff);
    static const componentChipsChipslabelcolorhover = Color(0xFF242629);
    static const componentDropdownDropdownbgcoloridle = Color(0xFF333d40);
    static const componentDropdownDropdownbgcolorhover = Color(0xFF4a5259);
    static const componentEmptiesEmptieslogocolor = Color(0xFF2b3038);
    static const componentEmptiesEmptiesbgcolor = Color(0xFF333d40);
    static const componentFoldoutFoldoutlabelcoloridle = Color(0xFFcfd4d9);
    static const componentFoldoutFoldoutlabelcoloractive = Color(0xFFf2f5f5);
    static const componentGalleryAppimagelightboxgallerybgcolor = Color(0xFF000000);
    static const componentHeyHeydrawersurfacecolor = Color(0xFF333d40);
    static const componentHeyHeyfavinputfieldsurfacecolor = Color(0xFF4a5259);
    static const componentHeyHeyiconutilcolor = Color(0xFFffffff);
    /** This is the most used color for separators across Bild products. */
    static const componentHeyHeyseparatorcolor = Color(0xFF666b70);
    static const componentHeyHeytextcolor = Color(0xFFe8edf0);
    static const componentInputfieldInputfieldbordercoloridle = Color(0xFF8c9196);
    static const componentInputfieldInputfieldbordercoloractive = Color(0xFFe8edf0);
    static const componentInputfieldInputfieldbordercolordark = Color(0xFFcfd4d9);
    static const componentInputfieldInputfieldbordercolordarkactive = Color(0xFFffffff);
    static const componentInputfieldInputfieldbgcolordarklowcontrast = Color(0xFF333d40);
    static const componentInputfieldInputfieldbgcolordarkmediumcontrast = Color(0xFF4a5259);
    static const componentInputfieldInputfieldbgcolordarkhighcontrast = Color(0xFFe8edf0);
    static const componentKickerStandardKickerbgcoloronsurface = Color(0xFF8c9196);
    static const componentKickerPartnerKickerbzbgcolor = Color(0xFFe3001c);
    static const componentKickerPartnerKickerfitbookbgcolor = Color(0xFFff96b8);
    static const componentKickerPartnerKickerpetbookbgcolor = Color(0xFFbadb91);
    static const componentKickerPartnerKickermyhomebookbgcolor = Color(0xFF66cccc);
    static const componentKickerPartnerKickertravelbookbgcolor = Color(0xFF8ff0ed);
    static const componentKickerPartnerKickertechbookbgcolor = Color(0xFF94e3ff);
    static const componentKickerPartnerKickerkaufberaterbgcolor = Color(0xFF54476e);
    static const componentKickerPartnerKickercobibgcolor = Color(0xFFdb241c);
    static const componentKickerPartnerKickeraubibgcolor = Color(0xFFf00000);
    static const componentKickerPartnerKickerspobibgcolor = Color(0xFF174582);
    static const componentMediaplayerVidplayercontrolsautoplaybuttonbgcolor = Color(0x33000000);
    /** This variable is used for hover states of video player control buttons. */
    static const componentMediaplayerVidplayercontrolbuttonsbghovercolor = Color(0xccde0000);
    static const componentMediaplayerVidplayercontrolbuttonsbgcolorhover = Color(0x33000000);
    static const componentMediaplayerVidplayercontrolbuttonsbgcolorpressed = Color(0x0d000000);
    static const componentMediaplayerVidplayeroverlayscrimcolor = Color(0x80000000);
    static const componentMediaplayerAudioplayerplaybuttonbgcolor = Color(0x4dffffff);
    static const componentMediaplayerVidplayertooltipbgcolor = Color(0xb3000000);
    static const componentMediaplayerVidplayerprogressbarpreloadbgcolor = Color(0x4dffffff);
    static const componentMediaplayerVidplayerunmutebuttonbgcolor = Color(0x33000000);
    static const componentMediaplayerVidplayerunmutebuttonbgcolorhover = Color(0x59000000);
    static const componentMenuMenusurfacecolor = Color(0xFF242629);
    /** Used on a thin part at the top of header in navigation menu. */
    static const componentMenuMenuscrolledsurfacegradientcolor = Color(0xf2242629);
    static const componentMenuMenulinklanesurfacecolor = Color(0xFF242629);
    static const componentMenuMenulinklanelabelcolor = Color(0xFF8c9196);
    static const componentMenuMenulinklanelabelcoloractive = Color(0xFFffffff);
    static const componentMenuApptopbarsurfacecolor = Color(0xFF333d40);
    static const componentMenuApptopbariconcolor = Color(0xFF8c9196);
    static const componentMenuApptopbartextcolorprimary = Color(0xFFe8edf0);
    static const componentMenuApptobbartabnavbottomborder = Color(0xFF4a5259);
    static const componentMenuApptobbartabnavbottomborderactive = Color(0xFFffffff);
    static const componentMenuitemMenuitemlabelcolorprimary = Color(0xFF8c9196);
    static const componentMenuitemMenuitemlabelcolorprimaryactive = Color(0xFFf2f5f5);
    /** The variable can be used on secondary menus that many times show up on dedicated home pages specific to a topic. The menu labels are often times using the color white across color modes. */
    static const componentMenuitemMenuitemlabelcolorsecondary = Color(0xFFffffff);
    static const componentMenuitemMenuitembordercoloractive = Color(0xFFffffff);
    /** !do not use! these variables have been deprecated and multitext link buttons are now classified as partner buttons. */
    static const componentPartnerlinksPartnerlinksbgcoloridle = Color(0xFF333d40);
    /** !do not use! these variables have been deprecated and multitext link buttons are now classified as partner buttons. */
    static const componentPartnerlinksPartnerlinksbgcoloractive = Color(0xFF8c9196);
    /** !do not use! these variables have been deprecated and multitext link buttons are now classified as partner buttons. */
    static const componentPartnerlinksPartnerlinksbordercoloridle = Color(0xFFcfd4d9);
    /** !do not use! these variables have been deprecated and multitext link buttons are now classified as partner buttons. */
    static const componentPartnerlinksPartnerlinksbordercoloractive = Color(0xFFe8edf0);
    /** !do not use! these variables have been deprecated and multitext link buttons are now classified as partner buttons. */
    static const componentPartnerlinksPartnerlinkscontainerbordercolor = Color(0xFF4a5259);
    static const componentNewstickerNewstickertimestampcolor = Color(0xFF8c9196);
    static const componentNewstickerNewstickerbadgeiconscolor = Color(0xFF8c9196);
    static const componentPaginationPaginationelementcolordefault = Color(0xFF8c9196);
    static const componentPaginationPaginationelementcoloractive = Color(0xFFffffff);
    /** Use this on gallery slider pagination elements. This can also be applied to hover states of those elements. */
    static const componentPaginationGallerypaginationelementactiveopacity = 100;
    /** Used as the background surface color scroll bars. Found on components that vertically or horizontally stack elements. */
    static const componentPaginationScrollbartrackbgcolor = Color(0x1affffff);
    /** Use on the scroll bar interactive element which shows where the scroll view is positioned inside the full extent of the scrolling space. */
    static const componentPaginationScrollbarthumbbgcolor = Color(0xFF8c9196);
    /** Checkboxes and Radio buttons use this variable for their border. */
    static const componentSelectionSelectionbordercolor = Color(0xFF8c9196);
    /** When users hover on gallery slider buttons the opacity changes to 90%. */
    static const componentSliderSliderbuttonopacity = 90;
    /** This variable is used on audio player slider bars. It references a pure white with 35% opacity. */
    static const componentSliderSlidertrackbgcolor = Color(0x59ffffff);
    static const componentSocialsharebuttonSocialsharebuttonlabelcolordefault = Color(0xFFffffff);
    static const componentSocialsharebuttonSocialsharebuttonlabelcoloractive = Color(0xFFffffff);
    static const componentSocialsharebuttonSocialsharebuttonbgcolordefault = Color(0xFF4a5259);
    static const componentSocialsharebuttonSocialsharebuttonbgcoloractive = Color(0xFF333d40);
    static const componentSubheaderSubheaderscolor = Color(0xFFe8edf0);
    static const componentTabTabbgcolorhover = Color(0xFF333d40);
    static const componentTabTablabelcoloractive = Color(0xFFf2f5f5);
    static const componentTabTablabelcolordefault = Color(0xFFffffff);
    static const componentTabAppbottomtabbarbgcolor = Color(0xFF333d40);
    /** When users hover over graphical teasers the image reduces opacity to 80%. */
    static const componentTeaserTeaserhoveropacity = 80;
    static const componentTeaserTeasertitlebackgroundgradientstart = Color(0xb3000000);
    static const componentTeaserTeasertitlebackgroundgradientstop = Color(0x00000000);
    static const componentTextlinkTextlinkcolorprimary = Color(0xFF8c9196);
    static const componentTextlinkTextlinkcolorsecondary = Color(0xFFcfd4d9);
    static const componentTextlinkTextlinkcolorsecondaryactive = Color(0xFFe8edf0);
    static const component_dsysdocDsdocspacingitembgcolor = Color(0x33ffffff);
    static const component_dsysdocDsdocspacingitembordercolor = Color(0xccffffff);
    /** This variable is only for use in Figma's Design System File. It is automating some of the content in documentation pages. */
    static const component_dsysdoc_dsysdocs_labeltextsurfacecolorprimaryprimitivename = "BILD010";
    /** This is currently for use in this design system's documentation texts. It is a text string made for being used in light and dark mode documentation texts. */
    static const component_dsysdoc_dsysdocs_labeltextcolormode = "(Dark Mode)";
}
