
//
// breakpoint_advertorial_md.dart
//

// Do not edit directly, this file was auto-generated.



import 'dart:ui';

class BreakpointAdvertorialMd {
    BreakpointAdvertorialMd._();

    /** 0-0-0-0 – no corner rounding. Used as default for flat layouts, content modules, images, and teaser elements. */
    static const semanticBorderBorderradiusBorderradiusnone = 0;
    /** 2-2-2-2 use for corner rounding on very small UI elements such as tooltips and badges. */
    static const semanticBorderBorderradiusBorderradiusxs = 2;
    /** 4-4-4-4 – use for corner rounding on compact components like checkboxes or small input controls. */
    static const semanticBorderBorderradiusBorderradiussm = 4;
    /** 8-8-8-8 – Standard radius for buttons, chips, input fields, and medium-sized interactive elements. */
    static const semanticBorderBorderradiusBorderradiusmd = 8;
    /** 16-16-16-16 – use for corner rounding on small cards, overlays, and modal surfaces. */
    static const semanticBorderBorderradiusBorderradiuslg = 16;
    /** 24-24-24-24 – use for corner rounding on larger cards, overlays, dialogs, and other container components. */
    static const semanticBorderBorderradiusBorderradiusxl = 24;
    /** creates fully rounded shapes, typically used for circular elements like avatars. */
    static const semanticBorderBorderradiusBorderradiusfull = 9999;
    /** 0.33 -0.33 -0.33 -0.33 – primarily used in mobile app interfaces. Optimized for high-density displays to create subtle dividers and outlines without visual overload. */
    static const semanticBorderBorderwidthBorderwidthhairline = 0.33;
    /** 1-1-1-1 – use for subtle outlines and dividers */
    static const semanticBorderBorderwidthBorderwidththin = 1;
    /** 2-2-2-2 – use for stronger outlines on form elements (inputs), buttons (outline variants), and interaction states (focus, hover, active) */
    static const semanticBorderBorderwidthBorderwidththick = 2;
    /** Common viewport width size based on the selected breakpoint.
Apply this token to the main frame of page layouts. */
    static const semanticLayoutCanvaswidthsizeweb = 600;
    /** Common viewport height size based on the selected mode.
Apply this token to the main frame of page layouts to simulate realistic vertical space. */
    static const semanticLayoutCanvasheightsizeweb = 960;
    /** Common viewport width size based on the selected breakpoint.
Apply this token to the main frame of page layouts. */
    static const semanticLayoutCanvaswidthsizeapp = 834;
    /** Common viewport height size based on the selected mode.
Apply this token to the main frame of page layouts to simulate realistic vertical space. */
    static const semanticLayoutCanvasheightsizeapp = 1194;
    /** 320 - 390 - 600 - 1024 – Defines the minimum width of the main frame for different breakpoints.
Apply this token to the main frame of page layouts to simulate realistic minimum widths across responsive viewports. */
    static const semanticLayoutBreakpointsBreakpointminwidthsize = 600;
    /** 389 - 599 - 1023 - 1024 – Defines the minimum width of the main frame for different breakpoints.
Apply this token to the main frame of page layouts to simulate realistic maximum widths across responsive viewports. */
    static const semanticLayoutBreakpointsBreakpointmaxwidthsize = 1023;
    /** Use for content containers that should not fill the full page width on larger viewports. This is commonly used on article body text content and other elements in an article page. */
    static const semanticLayoutContentwidthContentmaxwidthmedium = 700;
    /** Use for content containers that should fill the full width of the page */
    static const semanticLayoutContentwidthContentmaxwidthfull = 1024;
    /** 6-6-6-8 – use for side paddings and gutters in responsive layouts */
    static const semanticLayoutGridResponsiveGridspacerespsm = 6;
    /** 12-12-12-16 – use for side paddings and gutters in responsive layouts */
    static const semanticLayoutGridResponsiveGridspacerespbase = 12;
    /** 24-24-32-32 – use for side paddings and gutters in responsive layouts */
    static const semanticLayoutGridResponsiveGridspaceresplg = 32;
    /** 48-48-64-64 – use for side paddings and gutters in responsive layouts */
    static const semanticLayoutGridResponsiveGridspacerespxl = 64;
    /** 0-0-0-16 – This token is used on the main homepages content container, ensuring full-width layout (no horizontal padding) on mobile and tablet breakpoints. */
    static const semanticLayoutGridResponsivePageinlinespace = 0;
    /** 12-12-12-12 – use for fixed side paddings and gutters */
    static const semanticLayoutGridConstantGridspaceconstsm = 12;
    /** 16-16-16-16 – use for fixed side paddings and gutters */
    static const semanticLayoutGridConstantGridspaceconstlg = 16;
    /** Used to set the column count in Figma Layout guide Grids */
    static const semanticLayoutGridLayoutguideLayoutguidegridcolums = 8;
    /** 24-24-36-36 – Use for vertical spacing between subsections in a layout */
    static const semanticLayoutSectionSectionspacesm = 36;
    /** 36-36-48-48 – Use for vertical spacing between sections in a layout. */
    static const semanticLayoutSectionSectionspacebase = 48;
    /** 72-72-96-96 – Use for vertical spacing between sections in a layout */
    static const semanticLayoutSectionSectionspacelg = 96;
    /** 16-16-32-32 – Use for spacing after paragraphs in text content */
    static const semanticLayoutSectionParagraphendspace = 32;
    /** 2-2-4-6 – Use for gaps between items inside of UI elements that scale across breakpoints */
    static const semanticSpaceGapResponsiveGapspaceresp2xs = 4;
    /** 4-4-6-8 – Use for gaps between items inside of UI elements that scale across breakpoints */
    static const semanticSpaceGapResponsiveGapspacerespxs = 6;
    /** 8-8-12-16 – Use for gaps between items inside of UI elements that scale across breakpoints */
    static const semanticSpaceGapResponsiveGapspacerespsm = 12;
    /** 12-12-16-24 – Use for gaps between items inside of UI elements that scale across breakpoints */
    static const semanticSpaceGapResponsiveGapspacerespmd = 16;
    /** 16-16-24-32 – Use for gaps between items inside of UI elements that scale across breakpoints */
    static const semanticSpaceGapResponsiveGapspaceresplg = 24;
    /** 24-24-32-48 – Use for gaps between items inside of UI elements that scale across breakpoints */
    static const semanticSpaceGapResponsiveGapspacerespxl = 32;
    /** 32-32-48-64 – Use for gaps between items inside of UI elements that scale across breakpoints */
    static const semanticSpaceGapResponsiveGapspaceresp2xl = 48;
    /** 48-48-72-96 – Use for gaps between items inside of UI elements that scale across breakpoints */
    static const semanticSpaceGapResponsiveGapspaceresp3xl = 72;
    /** 2-2-2-2 – Use for fixed gaps between items inside of UI elements */
    static const semanticSpaceGapConstantGapspaceconst2xs = 2;
    /** 4-4-4-4 – Use for fixed gaps between items inside of UI elements */
    static const semanticSpaceGapConstantGapspaceconstxs = 4;
    /** 8-8-8-8 – Use for fixed gaps between items inside of UI elements */
    static const semanticSpaceGapConstantGapspaceconstsm = 8;
    /** 12-12-12-12 – Use for fixed gaps between items inside of UI elements */
    static const semanticSpaceGapConstantGapspaceconstmd = 12;
    /** 16-16-16-16 – Use for fixed gaps between items inside of UI elements */
    static const semanticSpaceGapConstantGapspaceconstlg = 16;
    /** 24-24-24-24 – Use for fixed gaps between items inside of UI elements */
    static const semanticSpaceGapConstantGapspaceconstxl = 24;
    /** 32-32-32-32 – Use for fixed gaps between items inside of UI elements */
    static const semanticSpaceGapConstantGapspaceconst2xl = 32;
    /** 48-48-48-48 – Use for fixed gaps between items inside of UI elements */
    static const semanticSpaceGapConstantGapspaceconst3xl = 48;
    /** 8-8-12-16 – use for horizontal (left/right) padding of UI elements that scales across breakpoints */
    static const semanticSpaceInlineResponsiveInlinespacerespsm = 12;
    /** 12-12-16-24 use for horizontal (left/right) padding of UI elements that scales across breakpoints */
    static const semanticSpaceInlineResponsiveInlinespacerespmd = 16;
    /** 16-16-24-32 – use for horizontal (left/right) padding of UI elements that scales across breakpoints */
    static const semanticSpaceInlineResponsiveInlinespaceresplg = 24;
    /** 24-24-32-40 – use for horizontal (left/right) padding of UI elements that scales across breakpoints */
    static const semanticSpaceInlineResponsiveInlinespacerespxl = 32;
    /** 32-32-48-64 – use for horizontal (left/right) padding of UI elements that scales across breakpoints */
    static const semanticSpaceInlineResponsiveInlinespaceresp2xl = 48;
    /** 2-2-2-2 – Use for fixed horizontal (left/right) padding of UI elements */
    static const semanticSpaceInlineConstantInlinespaceconst3xs = 2;
    /** 4-4-4-4 – Use for fixed horizontal (left/right) padding of UI elements */
    static const semanticSpaceInlineConstantInlinespaceconst2xs = 4;
    /** 6-6-6-6 – Use for fixed horizontal (left/right) padding of UI elements */
    static const semanticSpaceInlineConstantInlinespaceconstxs = 6;
    /** 8-8-8-8 – Use for fixed horizontal (left/right) padding of UI elements */
    static const semanticSpaceInlineConstantInlinespaceconstsm = 8;
    /** 12-12-12-12 – Use for fixed horizontal (left/right) padding of UI elements */
    static const semanticSpaceInlineConstantInlinespaceconstmd = 12;
    /** 16-16-16-16 – Use for fixed horizontal (left/right) padding of UI elements */
    static const semanticSpaceInlineConstantInlinespaceconstlg = 16;
    /** 24-24-24-24 – Use for fixed horizontal (left/right) padding of UI elements */
    static const semanticSpaceInlineConstantInlinespaceconstxl = 24;
    /** 32-32-32-32 – Use for fixed horizontal (left/right) padding of UI elements */
    static const semanticSpaceInlineConstantInlinespaceconst2xl = 32;
    /** 8-8-12-16 – use for vertical (top/bottom) padding of UI elements that scales across breakpoints */
    static const semanticSpaceStackResponsiveStackspacerespsm = 12;
    /** 12-12-16-24 – use for vertical (top/bottom) padding of UI elements that scales across breakpoints */
    static const semanticSpaceStackResponsiveStackspacerespmd = 16;
    /** 16-16-24-32 – use for vertical (top/bottom) padding of UI elements that scales across breakpoints */
    static const semanticSpaceStackResponsiveStackspaceresplg = 24;
    /** 24-24-32-40 – use for vertical (top/bottom) padding of UI elements that scales across breakpoints */
    static const semanticSpaceStackResponsiveStackspacerespxl = 32;
    /** 32-32-48-64 – use for vertical (top/bottom) padding of UI elements that scales across breakpoints */
    static const semanticSpaceStackResponsiveStackspaceresp2xl = 48;
    /** 2-2-2-2 – Use for fixed vertical (top/bottom) padding of UI elements */
    static const semanticSpaceStackConstantStackspaceconst3xs = 2;
    /** 4-4-4-4 – Use for fixed vertical (top/bottom) padding of UI elements */
    static const semanticSpaceStackConstantStackspaceconst2xs = 4;
    /** 6-6-6-6 – Use for fixed vertical (top/bottom) padding of UI elements */
    static const semanticSpaceStackConstantStackspaceconstxs = 6;
    /** 8-8-8-8 – Use for fixed vertical (top/bottom) padding of UI elements */
    static const semanticSpaceStackConstantStackspaceconstsm = 8;
    /** 12-12-12-12 – Use for fixed vertical (top/bottom) padding of UI elements */
    static const semanticSpaceStackConstantStackspaceconstmd = 12;
    /** 16-16-16-16 – Use for fixed vertical (top/bottom) padding of UI elements */
    static const semanticSpaceStackConstantStackspaceconstlg = 16;
    /** 24-24-24-24 – Use for fixed vertical (top/bottom) padding of UI elements */
    static const semanticSpaceStackConstantStackspaceconstxl = 24;
    /** 32-32-32-32 – Use for fixed vertical (top/bottom) padding of UI elements */
    static const semanticSpaceStackConstantStackspaceconst2xl = 32;
    /** 12-12-14-16 – Use for setting height and width of UI elements that scale across breakpoints */
    static const semanticSizeResponsiveSizeresp4xs = 14;
    /** 16-16-16-24 – Use for setting height and width of UI elements that scale across breakpoints */
    static const semanticSizeResponsiveSizeresp3xs = 16;
    /** 24-24-32-32 – Use for setting height and width of UI elements that scale across breakpoints */
    static const semanticSizeResponsiveSizeresp2xs = 32;
    /** 32-32-40-48 – Use for setting height and width of UI elements that scale across breakpoints */
    static const semanticSizeResponsiveSizerespxs = 40;
    /** 40-40-48-56 – Use for setting height and width of UI elements that scale across breakpoints */
    static const semanticSizeResponsiveSizerespsm = 48;
    /** 48-48-64-72 – Use for setting height and width of UI elements that scale across breakpoints */
    static const semanticSizeResponsiveSizerespmd = 64;
    /** 56-56-72-92 – Use for setting height and width of UI elements that scale across breakpoints */
    static const semanticSizeResponsiveSizeresplg = 72;
    /** 64-64-80-96 – Use for setting height and width of UI elements that scale across breakpoints */
    static const semanticSizeResponsiveSizerespxl = 80;
    /** 72-72-92-100 – Use for setting height and width of UI elements that scale across breakpoints */
    static const semanticSizeResponsiveSizeresp2xl = 92;
    /** 96-96-120-148 – Use for setting height and width of UI elements that scale across breakpoints */
    static const semanticSizeResponsiveSizeresp3xl = 120;
    /** 148-148-160-180 – Use for setting height and width of UI elements that scale across breakpoints */
    static const semanticSizeResponsiveSizeresp4xl = 160;
    /** 8-8-8-8 – Use for setting fixed height and width of UI elements */
    static const semanticSizeConstantSizeconst4xs = 8;
    /** 16-16-16-16 – Use for setting fixed height and width of UI elements */
    static const semanticSizeConstantSizeconst3xs = 16;
    /** 24-24-24-24 – Use for setting fixed height and width of UI elements */
    static const semanticSizeConstantSizeconst2xs = 24;
    /** 32-32-32-32 – Use for setting fixed height and width of UI elements */
    static const semanticSizeConstantSizeconstxs = 32;
    /** 40-40-40-40 – Use for setting fixed height and width of UI elements */
    static const semanticSizeConstantSizeconstsm = 40;
    /** 48-48-48-48 Use for setting fixed height and width of UI elements */
    static const semanticSizeConstantSizeconstmd = 48;
    /** 56-56-56-56 – Use for setting fixed height and width of UI elements */
    static const semanticSizeConstantSizeconstlg = 56;
    /** 64-64-64-64 – Use for setting fixed height and width of UI elements */
    static const semanticSizeConstantSizeconstxl = 64;
    /** 72-72-72-72 – Use for setting fixed height and width of UI elements */
    static const semanticSizeConstantSizeconst2xl = 72;
    /** 96-96-96-96 – Use for setting fixed height and width of UI elements */
    static const semanticSizeConstantSizeconst3xl = 96;
    /** 148-148-148-148 – Use for setting fixed height and width of UI elements */
    static const semanticSizeConstantSizeconst4xl = 148;
    /** This variable references the bodyFontFamily variable from the branding collection. */
    static const semanticTypographyFontfamilyBodyfontfamily = "Lucida Grande";
    static const semanticTypographyFontfamilyCalloutfontfamily = "Lucida Grande";
    static const semanticTypographyFontfamilyDisplayfontfamily = "Lucida Grande";
    static const semanticTypographyFontfamilyFootnotefontfamily = "Lucida Grande";
    static const semanticTypographyFontfamilyHeadlinefontfamily = "Lucida Grande";
    static const semanticTypographyFontfamilyKickerfontfamily = "Lucida Grande";
    static const semanticTypographyFontfamilyLabelfontfamily = "Lucida Grande";
    static const semanticTypographyFontfamilySubheadlinefontfamily = "Lucida Grande";
    static const semanticTypographyFontfamilyTitlefontfamily = "Lucida Grande";
    static const semanticTypographyFontfamilyQuotefontfamily = "Lucida Grande";
    /** This variable is used on the body text style's font size parameter. It remains constant at 21. */
    static const semanticTypographyFontsizeBodyBodyfontsize = 17;
    /** This token is used for the font size parameter of the callout text style. 18 - 18 - 22 - 22 */
    static const semanticTypographyFontsizeCalloutCallout1fontsize = 22;
    /** This variable is used on the font size parameter for the display1 text style. 40 - 40 - 72 - 120 */
    static const semanticTypographyFontsizeDisplayDisplay1fontsize = 70;
    /** This variable is used for the font size parameter of the Display2 text style. 36 - 36 - 42 - 64 */
    static const semanticTypographyFontsizeDisplayDisplay2fontsize = 41;
    /** This variable is used on the display3 font size parameter of the display3 text style. 28 - 28 - 32 - 40 */
    static const semanticTypographyFontsizeDisplayDisplay3fontsize = 31;
    /** This token is used on the footnote text style font size parameter. 16 - 16 - 16 - 18 */
    static const semanticTypographyFontsizeFootnoteFootnote1fontsize = 13;
    /** This token is used in the font size parameter of the footnote2 text style. 12 - 12 - 12 - 16 */
    static const semanticTypographyFontsizeFootnoteFootnote2fontsize = 10;
    /** This token is used for the headline1 text style's font size parameter. 48 - 48 - 72 - 100 */
    static const semanticTypographyFontsizeHeadlineHeadline1fontsize = 54;
    /** This token is used on the headline2 text style's font size parameter. 40 - 40 - 48 - 64 */
    static const semanticTypographyFontsizeHeadlineHeadline2fontsize = 36;
    /** This token is used on the headline3 text style's font size parameter. 28 - 28 - 36 - 40 */
    static const semanticTypographyFontsizeHeadlineHeadline3fontsize = 26;
    /** This token controls the headline4 text style's font size parameter: 22 - 22 - 26 - 32 */
    static const semanticTypographyFontsizeHeadlineHeadline4fontsize = 20;
    /** Values come from NMT Figma File 01_Foundation; in online CSS this is kicker0. 18 - 18 - 22 - 30 - This variable does not exist yet in online css. Online css is called kicker0 for smallest font size. */
    static const semanticTypographyFontsizeKickerKicker1fontsize = 18;
    /** Values come from comparing NMT Figma File 01_Foundation to online CSS. Online kickers are numbered from 0 to 3. This DS uses 1 to 4 following html convention of h1, h2, h3, etc. 18 - 18 - 22 - 24 */
    static const semanticTypographyFontsizeKickerKicker2fontsize = 18;
    /** Values come from comparing NMT Figma File 01_Foundation to online CSS. Online kickers are numbered from 0 to 3. 16 - 16 - 18 - 20 */
    static const semanticTypographyFontsizeKickerKicker3fontsize = 14;
    /** Values come from comparing NMT Figma File 01_Foundation to online CSS. Online kickers are numbered from 0 to 3. 14 - 14 - 16 - 16 */
    static const semanticTypographyFontsizeKickerKicker4fontsize = 14;
    /** This token is used in the label1 text style font size parameter. Its value remains constant at 17 across device sizes. */
    static const semanticTypographyFontsizeLabelLabel1fontsize = 17;
    /** 10 - 10 - 15 - 17 Use this label font size when you want your label's font size to change across device sizes. */
    static const semanticTypographyFontsizeLabelLabel1fontsizeresponsive = 15;
    /** This variable controls the label2 text style's font size parameter. Its value remains constant at 15. */
    static const semanticTypographyFontsizeLabelLabel2fontsize = 15;
    /** This token is used in the label3 text style's font size parameter. Its value remains constant at 12 across device sizes. */
    static const semanticTypographyFontsizeLabelLabel3fontsize = 12;
    /** This token is used in the font size parameter of the label4 text style. The value remains constant at 8. */
    static const semanticTypographyFontsizeLabelLabel4fontsize = 8;
    /** This token controls the subheadline1 font size parameter. 24 - 24 - 32 - 36 */
    static const semanticTypographyFontsizeSubheadlineSubheadline1fontsize = 18;
    /** 22 - 22 - 22 - 28 -- html class stage-block-title__text css var --ressort-header-font-size(sm-md-lg) */
    static const semanticTypographyFontsizeTitleTitle1fontsize = 22;
    /** 16 - 16 - 18 - 20 - html class stage-block-title__text css var --ressort-header-font-size(sm-md-lg) */
    static const semanticTypographyFontsizeTitleTitle2fontsize = 16;
    /** 16 - 16 - 18 - 20 -- This variable is used for controlling the font size of the quote text style. */
    static const semanticTypographyFontsizeQuoteQuotefontsize = 16;
    static const semanticTypographyFontweightBodyBodyfontweightbook = 400;
    static const semanticTypographyFontweightBodyBodyfontweightbold = 700;
    static const semanticTypographyFontweightCalloutCalloutfontweight = 800;
    static const semanticTypographyFontweightDisplayDisplayfontweight = 800;
    static const semanticTypographyFontweightFootnoteFootnotefontweightbold = 700;
    static const semanticTypographyFontweightFootnoteFootnotefontweightbook = 400;
    static const semanticTypographyFontweightHeadlineHeadline1fontweight = 700;
    /** This variable is a string type variable for controlling not only headline font weight but also the italic style for Sport Bild headlines. */
    static const semanticTypographyFontweightHeadlineHeadline1fontweightst = "700";
    static const semanticTypographyFontweightHeadlineHeadline2fontweight = 700;
    static const semanticTypographyFontweightHeadlineHeadline3fontweight = 700;
    static const semanticTypographyFontweightHeadlineHeadline4fontweight = 600;
    static const semanticTypographyFontweightKickerKickerfontweight = 700;
    static const semanticTypographyFontweightKickerKickerfontweightst = "700";
    static const semanticTypographyFontweightLabelLabelfontweightbook = 400;
    static const semanticTypographyFontweightLabelLabelfontweightbold = 700;
    static const semanticTypographyFontweightSubheadlineSubheadlinefontweight = 700;
    static const semanticTypographyFontweightTitleTitlefontweight = 800;
    static const semanticTypographyFontweightQuoteQuotefontweight = 800;
    /** Figma's font line height currently does not allow for multipliers as is used on current website css var(--body-line-height) */
    static const semanticTypographyLineheightBodyBodylineheight = 29.75;
    static const semanticTypographyLineheightCalloutCalloutlineheight = 28.6;
    static const semanticTypographyLineheightDisplayDisplay1lineheight = 72;
    static const semanticTypographyLineheightDisplayDisplay2lineheight = 42;
    static const semanticTypographyLineheightDisplayDisplay3lineheight = 32;
    static const semanticTypographyLineheightFootnoteFootnote1lineheight = 16.9;
    static const semanticTypographyLineheightFootnoteFootnote2lineheight = 13;
    static const semanticTypographyLineheightHeadlineHeadline1lineheight = 56.7;
    static const semanticTypographyLineheightHeadlineHeadline2lineheight = 39.6;
    static const semanticTypographyLineheightHeadlineHeadline3lineheight = 28.6;
    static const semanticTypographyLineheightHeadlineHeadline4lineheight = 19.8;
    static const semanticTypographyLineheightKickerKicker1lineheight = 19.8;
    static const semanticTypographyLineheightKickerKicker2lineheight = 19.8;
    static const semanticTypographyLineheightKickerKicker3lineheight = 15.4;
    static const semanticTypographyLineheightKickerKicker4lineheight = 15.4;
    /** This variable is used in the label1 text style's line height parameter. It references branding variables for brand specific line heights. */
    static const semanticTypographyLineheightLabelLabel1lineheight = 20.4;
    static const semanticTypographyLineheightLabelLabel1responsivelineheight = 15;
    static const semanticTypographyLineheightLabelLabel2lineheight = 16;
    static const semanticTypographyLineheightLabelLabel3lineheight = 14.4;
    static const semanticTypographyLineheightLabelLabel4lineheight = 10;
    static const semanticTypographyLineheightSubheadlineSubheadline1lineheight = 23.4;
    static const semanticTypographyLineheightTitleTitle1lineheight = 26.4;
    /** html class stage-block-title__text css var --ressort-header-font-size(sm-md-lg) */
    static const semanticTypographyLineheightTitleTitle2lineheight = 19.2;
    /** This variable is used in the quote text style line height parameter. */
    static const semanticTypographyLineheightQuoteQuotelineheight = 20.8;
    /** 2 | 2 | 2 | 3 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. */
    static const semanticTypographyLetterspacingLetterspacingpositivelg = 2;
    /** 1 | 1 | 1 | 1 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. */
    static const semanticTypographyLetterspacingLetterspacingpositivemd = 1;
    /** 0.5 | 0.5 | 0.5 | 0.5 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. */
    static const semanticTypographyLetterspacingLetterspacingpositivesm = 0.5;
    /** 0.25 | 0.25 | 0.25 | 0.25 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. */
    static const semanticTypographyLetterspacingLetterspacingpositivexs = 0.25;
    /** 0 | 0 | 0 | 0 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. */
    static const semanticTypographyLetterspacingLetterspacingnone = 0;
    /** -0.25 | -0.25 | -0.25 | -0.25 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. This letter spacing was only found in large titles on iOS mobile app large title component. */
    static const semanticTypographyLetterspacingLetterspacingnegativexs = -0.25;
    /** -0.5 | -0.5 | -0.25 | -0.25 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. */
    static const semanticTypographyLetterspacingLetterspacingnegativesm = -0.25;
    /** -1 | -1 | -1 | -1 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. */
    static const semanticTypographyLetterspacingLetterspacingnegativemd = -1;
    /** -2 | -2 | -2 | -3 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. */
    static const semanticTypographyLetterspacingLetterspacingnegativelg = -2;
    /** -0.5 | -0.5 | -1 | -2 | This variable is used for the letter spacing parameter of the display1 text style. On smaller devices the value is smaller than on larger devices. On desktop devices the letter spacing is further reduced for making the text style more compact. */
    static const semanticTypographyLetterspacingDisplayDisplay1letterspacing = -1;
    /** -0.5 | -0.5 | -1 | -1 | This variable is used for the letter spacing parameter of the display2 text style. On smaller devices the value is smaller than on larger devices. */
    static const semanticTypographyLetterspacingDisplayDisplay2letterspacing = -1;
    /** -0.5 | -0.5 | -1 | -1 | This variable is used for the letter spacing parameter of the display3 text style. On smaller devices the value is smaller than on larger devices. */
    static const semanticTypographyLetterspacingDisplayDisplay3letterspacing = -1;
    /** Use for showing elements on desktop viewport sizes only */
    static const semanticVisibilityBooleanVisilbledesktoponly = false;
    /** Use for showing elements on tablet viewport sizes only */
    static const semanticVisibilityBooleanVisilbletabletonly = true;
    /** Use for showing elements on mobile viewport sizes only */
    static const semanticVisibilityBooleanVisilblemobileonly = false;
    /** Use for showing elements on viewport sizes above 600 px */
    static const semanticVisibilityBooleanVisilbleabove600px = true;
    /** Use for showing elements on viewport sizes below 600 px */
    static const semanticVisibilityBooleanVisilblebelow600px = false;
    /** Use for hiding elements on desktop viewport sizes only */
    static const semanticVisibilityBooleanHideondesktop = true;
    /** Use for hiding elements on mobile viewport sizes */
    static const semanticVisibilityBooleanHideonmobile = true;
    static const semanticVisibilityVariantswitchBpspecificweb = "md";
    static const semanticVisibilityVariantswitchBpspecificapp = "regular";
    static const semanticVisibilityVariantswitchChangeonlg = "xs/sm/md";
    /** This variable is used for controlling size changes across device sizes on some components such as the vertical newsticker cards and the search results cards. Both have cards that change layouts at different breakpoints. */
    static const semanticVisibilityVariantswitchChangeonmd = "md/lg";
    /** This variable exists specifically for changing the accordion font family across brands. It is subject to review. Bild: GothamXNarrow, SpoBi: Inter, Ads: LucindaGrande */
    static const componentAccordionAccordionlabelfontfamily = "Lucida Grande";
    /** This variable is used for setting the size of avatar images in article pages. It references the sizeConstMD variable from the "generic" semantic collection. Its value is 48 across devices. */
    static const componentAvatarAvatararticlesize = 48;
    /** 96 - 96 - 130 - 130 This variable is used for controlling the size of the avatar image on author pages. */
    static const componentAvatarAvatarauthorpagesize = 130;
    /** This variable is used on avatar names in article pages. Bild: 16 - 16 - 16 - 18; SpoBi&Ads: 13 - 13 - 13 - 15 */
    static const componentAvatarAvatarlabelfontsize = 13;
    /** This variable is used for controlling the line height of avatar texts. Its values influence the stacking space between avatar texts. 21 - 21 - 21 - 23 */
    static const componentAvatarAvatarlabellineheight = 21;
    /** This variable is used in avatar text styles. It receives values from the Brand Tokens Collection. Bild: GothamXNarrow; SpoBi: Inter; Ads: LucidaGrande */
    static const componentAvatarAvatarfontfamily = "Lucida Grande";
    /** This variable is used for setting the inline space between multiple avatars that are horizontally placed in a lane when an article has multiple authors. 16 - 16 - 24 - 24 */
    static const componentAvatarAvatarlanegapspace = 24;
    /** This variable is used for setting the font of avatars on iOS and Android platforms. This is subject to review. */
    static const componentAvatarAppavatarfontfamily = "Lucida Grande";
    /** This variable is used to control the font size of kickers in the heading section of article pages. 18 - 18 - 22 - 30 */
    static const componentArticleArticlekickerfontsize = 18;
    /** 40 - 40 - 72 - 100 - This variable uses the semantic variables headline2 for XS&SM, headline1 for MD&LG */
    static const componentArticleArticleheadlinefontsize = 54;
    /** CSS --article-figure-meta-font-size 16-16-18-18 */
    static const componentArticleArticleimagecaptionfontsize = 13;
    /** this component level variable references the branding variables */
    static const componentArticleArticleimagecaptionlineheight = 19.5;
    /** This variable is used on the font size of article day&time stamp that usually shows up along with the article author avatars. On app versions this variable is used for the avatar names. 12 - 12 - 14 - 16 */
    static const componentArticleArticlemetafontsize = 14;
    /** This variable is used on the font size of article day&time stamp that usually shows up along with the article author avatars. On app versions this variable is used for the avatar names. This variable references variables from the branding collection. */
    static const componentArticleArticlemetafontfamily = "Lucida Grande";
    /** 8 | 8 | 12 | 16 - This space variable is used at the top edge of the article main content bounding box. */
    static const componentArticleArticletopmarginspace = 12;
    static const componentArticleAriclemobile1colgridimagemarginspace = 72;
    /** 12 | 12 | 12 | 16 - This spacing variable is used for the space between article page heading kickers, headlines and subheadlines. XS&SM need review; correct value might be 8 */
    static const componentArticleArticleheadingsstackspace = 12;
    /** 16 | 16 | 72 | 16 - This variable is used for the left and right space within the article page headings container which holds the article page kicker, headline and subheadline. */
    static const componentArticleArticleheadingsinlinespace = 72;
    /** 16 - 16 - 24 - 32 - This variable creates the vertical spacing between different article body elements such as avatars, media players, corssheadings, paragraphs, field sets, images, tables, quotes, videos, social embeds, etc. */
    static const componentArticleArticlecontentstackspace = 24;
    /** 16 | 16 | 72 | 162 - This variable is used for making the left and right spacings around article content blocks. Current css has the article-body class assigned to a div and article body contains these horizontal padding values. */
    static const componentArticleArticlecontentinlinespace = 72;
    /** same as standard teaser width size variable */
    static const componentArticleArticlegalleryateaserwidth = 260;
    /** NMT CSS --article-figure-meta-font-size */
    static const componentArticleArticleimagesourcefontsize = 13;
    static const componentArticleArticleimagesourcelineheight = 19;
    static const componentArticleArticleimagecontainerstackspace = 12;
    static const componentArticleArticleimagelandscapeinlinespace = 12;
    static const componentArticleArticleimageportaitinlinespace = 72;
    static const componentArticleArticleinfoboxinlinespace = 24;
    static const componentArticleArticleinfoboxstackspace = 24;
    /** This variable is used in the text style dedicated to audio player labels for elapsed time, reproduction speed and short functionality description text. 16 - 16 - 16 - 18 */
    static const componentAudioplayerAudioplayerfontsize = 16;
    /** 30 - 30 - 30 - 30 - This variable is used on the Advert rectangular badge that is found above an ad containers. */
    static const componentBadgeAdlabelbadgeheightsize = 30;
    /** This space variable is used for creating the top and bottom space between a badge's text label and the surface that the text label is on top of. */
    static const componentBadgeBadgesinnerstackspace = 2;
    /** This space variable is used for creating the left and right space between a badge's text label and the badge background surface that the text label is on top of. */
    static const componentBadgeBadgesinnerinlinespace = 4;
    static const componentBreadcrumbBreadcrumbfontfamily = "Lucida Grande";
    /** 15 - 15 - 15 - 12 -- Breadcrumbs have a slightly larger font size on mobile devices compared to when they are rendered on larger desktop devices. */
    static const componentBreadcrumbBreadcrumbfontsize = 15;
    /** 15 - 15 - 15 - 12 -- Breadcrumbs have a slightly larger font size on mobile devices compared to when they are rendered on larger desktop devices. */
    static const componentBreadcrumbBreadcrumblineheight = 15;
    static const componentBreadcrumbBreadcrumb&arrowleftinlinespace1 = 3;
    static const componentBreadcrumbBreadcrumb&arrowrightinlinespace2 = 5;
    static const componentBreadcrumbBreadcrumbinlinespace = 12;
    static const componentBreadcrumbBreadcrumbfontweight = 700;
    static const componentBreadcrumbBreadcrumbstackspace = 14;
    static const componentBreakingnewsBreakingnewscontainerheightsize = 56;
    static const componentBreakingnewsBreakingnewsbadgeinlinespace = 12;
    static const componentBreakingnewsBreakingnewsbadgetitelsstackspace = 4;
    static const componentBreakingnewsBreakingnewsbadgeuppertitlefontsize = 17;
    static const componentBreakingnewsBreakingnewsbadgeuppertitlelineheight = 12;
    static const componentBreakingnewsBreakingnewsbadgelowertitlefontsize = 30;
    static const componentBreakingnewsBreakingnewsbadgelowertitlelineheight = 21;
    static const componentBreakingnewsBreakingnewsscrollingtextfontsize = 21;
    static const componentBreakingnewsBreakingnewsscrollingtextlineheight = 24;
    static const componentButtonButtonlabelfontsize = 15;
    static const componentButtonButtonlabellineheight = 15;
    static const componentButtonButtoncontentgapspace = 6;
    static const componentButtonButtoninlinespace = 16;
    static const componentButtonButtonstackspace = 6;
    static const componentButtonButtonborderwidthsize = 2;
    /** This fixed height variable ensures that the button maintains a consistent height, even when the icon is not active. */
    static const componentButtonButtoncontentminheightsize = 24;
    /** Use this variable for controlling the font size of partner buttons. 16 - 16 - 16 - 18 */
    static const componentButtonPartnerlinkbuttonlabelfontsize = 16;
    static const componentButtonPartnerlinkbuttoninlinespace = 8;
    static const componentButtonPartnerlinkbuttonlabelheightsize = 48;
    static const componentButtonButtonborderradius = 8;
    static const componentCardsSearchresultcardimagewidthsize = 216;
    static const componentCardsSearchresultcardimageheightsizestacked = 189;
    static const componentCardsNewstickerimagecardwidthsize = 206;
    /** This token is used to create more bottom padding space on system teaser headlines inside the gallery to avoid overlapping with the pagination. */
    static const componentCarouselGalleryteasertitlebottomspace = 36;
    /** This token is used to create more bottom padding space on system teaser headlines inside the gallery to avoid overlapping with the pagination. */
    static const componentCarouselGalleryteaserappgapspace = 8;
    static const componentCarouselAppepapercarouselitemdefaultwidth = 172;
    static const componentCarouselAppepapercarouselitemfocuswidth = 240;
    static const componentCarouselAppepapercarousebeilageitemwidth = 172;
    static const componentCarouselStandardteasergalleryteaserwidthweb = 260;
    static const componentCarouselStandardteasergalleryteaserwidthapp = 280;
    /** This variable is used on the chips font size parameter of the chips text style. The font size changes only for the change between larger device widths and any device smaller than the largest. 16 - 16 -16 - 18 */
    static const componentChipsChipsfontsize = 16;
    static const componentChipsChipsinlinespace = 12;
    static const componentChipsChipsstackspace = 8;
    static const componentDatepickerDatepickeritemdaywidthsize = 44;
    static const componentDatepickerDatepickeritemyearwidthsize = 77;
    static const componentDatepickerDatepickeritemheightsize = 44;
    static const componentDrawersMobilemenudrawerstackspace = 20;
    static const componentDrawersMobilemenudrawerleftinlinespace = 20;
    static const componentDrawersMobilemenudrawerrightinlinespace = 16;
    static const componentDrawersMobilemenudrawermaxwidthsize = 400;
    static const componentDropdownDropdownitemstackspace = 8;
    static const componentDropdownDropdowniteminlinespace = 12;
    static const componentDropdownDropdownborderradius = 4;
    static const componentFooterFooterfontfamily = "Gotham XNarrow";
    /** This variable is used on footer links that commonly show up at the bottom of pages. The font size parameter remains constant at 11 px across device sizes. */
    static const componentFooterFooterfontsize = 11;
    static const componentFooterFooterlineheight = 14;
    static const componentFooterFooterfontsizeuserofferpages = 18;
    static const componentFooterFooterlineheightuserofferpages = 26;
    static const componentIconIconsize = 24;
    static const componentIconIconsizeembeddmedia = 40;
    static const componentInfoelementInfoelementteaserbadgemarginspace = 4;
    static const componentInfoelementInfoelementteaserimageheightsize = 83;
    static const componentInfoelementInfoelementteaserimagewidthsize = 148;
    static const componentInfoelementInfoelementteaserbadgeheightsize = 16;
    /** This variable controls texts inside of input fields such as dropdowns, date input and other text inputs that appear in forms for example. compact 15 - default 17 - spacious 19 */
    static const componentInputfieldInputfieldfontsize = 16;
    static const componentInputfieldInputfieldfontfamily = "Lucida Grande";
    static const componentInputfieldInputfieldinlinespace = 16;
    static const componentInputfieldInputfieldstackspace = 6;
    static const componentInputfieldInputfieldmessagegapspace = 4;
    static const componentInputfieldInputfieldimessageinlinespace = 16;
    static const componentInputfieldInputfieldminilabelinlinespace = 4;
    static const componentInputfieldInputfieldheightsize = 36;
    static const componentInputfieldHeyinputcontainerinlinespace = 8;
    static const componentLivetickerLivetickerappcardheightsize = 128;
    static const componentLivetickerLivetickerappcardwidthsize = 300;
    static const componentLivetickerTimestampfontfamily = "Gotham XNarrow";
    static const componentLivetickerLivetickerheadlinefontweight = 600;
    /** This variable is used for the font size of live ticker headlines. 22 - 22 - 32 - 32 */
    static const componentLivetickerLivetickerheadlinesfontsize = 32;
    /** This variable is used for the live ticker time stamp font size. 14 - 14 - 16 - 16 */
    static const componentLivetickerLivetickertimestampfontsize = 16;
    static const componentLivetickerLivetickertime&headlinestackspace = 4;
    static const componentLivetickerLivetickerslideritemwidthmaxsize = 257;
    static const componentMediaplayerAudioplayerheaderstackspace = 56;
    static const componentMediaplayerPodcastplaybuttonsize = 48;
    static const componentMediaplayerVidplayerbottombargapspace = 0;
    static const componentMediaplayerVideotimebadgefontfamily = "Lucida Grande";
    static const componentMediaplayerVidplayercontrolbuttonsize = 42;
    static const componentMediaplayerVidplayercontrolbuttoniconsizehover = 28;
    static const componentMediaplayerVidplayertimecodefontsize = 16;
    static const componentMediaplayerVidplayertimecodecontainerminwidthsize = 58;
    static const componentMediaplayerVidplayerprogressbarcontainerheightsize = 24;
    static const componentMediaplayerVidplayerunmutebuttonwidthsize = 220;
    static const componentMenuMenulinklaneheightsize = 48;
    static const componentMenuMenulogodefaultsize = 56;
    static const componentMenuMenulogoscrolledsize = 56;
    static const componentMenuMenuutillinkitemheightsize = 48;
    static const componentMenuMenuitemutilfontsize = 12;
    /** This variable is used on the menu link lane and on the mobile side menu drawer. */
    static const componentMenuMenuitemfontsize = 15;
    static const componentMenuMenuspecialnaviitemheightsize = 48;
    static const componentMenuMenuitemspace = 8;
    static const componentMenuMenulinkiteminlinespace = 4;
    static const componentMenuMenuitemutilstackspace = 10;
    static const componentMenuSubnavbarheightsize = 42;
    static const componentMenuMenuutilitylinkscontainerheightsize = 56;
    static const componentMenuMenutopstackspace = 8;
    static const componentMenuMenubottomstackspace = 8;
    static const componentMenuMenuleftinlinespace = 8;
    static const componentMenuMenurightinlinespace = 0;
    static const componentMenuMenuutilitylinksgapspace = 24;
    static const componentMenuMenuutilitylinksdividerheightsize = 40;
    /** This color type variables are only in this semantic collection for making subtle shadow effects change visibility across device sizes. Shadow alpha: 10 - 10 - 10 - 0 */
    static const componentMenuMenushadowvisibility = Color(0x1a000000);
    /** This color type variables are only in this semantic collection for making subtle shadow effects change visibility across device sizes. Shadow alpha: 0 - 0 - 0 - 10 */
    static const componentMenuHeyinputshadowvisibility = Color(0x00000000);
    static const componentMenuIosapptopbarheightsize = 48;
    static const componentMenuIosapptopbarleftinlinespace = 19;
    static const componentMenuIosapptopbarrightinlinespace = 19;
    static const componentMenuApptopbartitlefontsize = 14;
    static const componentMenuApptopbarstagetitleheight = 17;
    static const componentNewstickerNewstickerappcardheightsize = 150;
    static const componentNewstickerNewstickerappcardwidthsize = 300;
    static const componentNewstickerNewstickertimefontfamily = "Lucida Grande";
    static const componentNewstickerNewstickertimefontweight = 700;
    /** similar to kicker3 values - 16 - 16 - 16 - 18 */
    static const componentNewstickerNewstickertimefontsize = 16;
    /** Figma currently does not allow for percentages in Line Height variables. The values in this token are the result of multiplying the font size by the line height variable defined on the Bild home css -> newsTickerTime line height: 1.3. Line height for this component does not change across devices. */
    static const componentNewstickerNewstickertimelineheight = 20.8;
    static const componentNewstickerNewstickerbadgesinlinespace = 12;
    static const componentNewstickerNewstickerentriesstackspace = 22;
    static const componentNewstickerNewstickerentriesleftinlinespace = 22;
    static const componentNewstickerNewstickercontentstackspace = 4;
    static const componentNewstickerNewstickerkickerinnerinlinespace = 4;
    static const componentNewstickerNewstickerkickerinnerstackspace = 2;
    static const componentNewstickerNewstickertime&kickerstackspace = 6;
    static const componentNewstickerNewstickertitlesinlinespace = 24;
    static const componentNewstickerNewstickerskeletonbottomspace = 0;
    static const componentNewstickerNewstickerreddotsize = 14;
    static const componentNewstickerNewstickerlineinlinespace = 7;
    static const componentPaginationGallerypaginationitemheightsize = 4;
    /** 8 - 8 - 12 - 12 - this component level variable references the inlineSpaceConst semantic variables; SM for smaller devices, MD for larger devices */
    static const componentPaginationGallerypaginationcontainerwebinlinespace = 12;
    static const componentPaginationGallerypaginationcontainerappinlinespace = 12;
    /** 12 - 12 - 16 - 16 - this component level variable references the semantic */
    static const componentPaginationGallerypaginationcontainerstackspace = 16;
    static const componentPaginationScrollbarthicknesssize = 8;
    static const componentPaywallPaywallcardmaxwidthsize = 346;
    /** This variable is used on the paywall card price tag. 64 constant */
    static const componentPaywallPaywallcardpricetagfontsize = 64;
    static const componentPaywallPaywallcardpricetaglineheight = 64;
    /** This variable is used on the paywall card text under the price tag. 40 - 40 - 40 - 40 */
    static const componentPaywallPaywallcardpricenotefontsize = 40;
    static const componentPaywallPaywallcardpricenotelineheight = 40;
    static const componentPaywallPaywallcontainergapspace = -48;
    static const componentPaywallPaywallheaderbottomstackspace = 80;
    static const componentQuotesQuotecontainerinlinespace = 16;
    static const componentQuotesQuotecontentgapspace = 48;
    static const componentQuotesQuotecontainerstackspace = 24;
    static const componentQuotesQuotequotationmarksfontsize = 32;
    static const componentRadiobuttonsRadioselectorsize = 20;
    static const componentRadiobuttonsRadioselectordotactivesize = 12;
    static const componentSearchSearchresultbadgeheightsize = 18;
    static const componentSectiontitleSectiontitleinnerstackbottomspace = 12;
    /** This variable is used on large title headings that are h2 elements in html and indicate a new section in the user interface. This space changes when a user hovers over the large title. */
    static const componentSectiontitleSectiontitle&arrowinlinespace = 5;
    /** This variable is used for increasing the space between the text and the arrow at the end of the large title text. On mobile devices there is no hover state so this variables values are the same as the default state values. */
    static const componentSectiontitleSectiontitle&arrowinlinespaceactive = 5;
    static const componentSectiontitleSectiontitleheightsize = 32;
    static const componentSeparatorsSeparatorthicknesssize = 2;
    static const componentSkeletonsHeadlinesskeletonimageplaceholdermaxwidth = 160;
    static const componentSkeletonsArticleskeletonimageinlinespace = 48;
    static const componentSkeletonsArticleskeletontextinlinespace = 48;
    static const componentSkeletonsArticletextskeletonheightsize = 720;
    static const componentSpecialnaviSpecialnaviinlinespace = 24;
    static const componentSlidersSliderprogressbaridleheightsize = 4;
    static const componentSlidersSliderprogressbarhoverheightsize = 8;
    static const componentSlidersSliderprogressinactiveheightsize = 2;
    static const componentSlidersVidplayerprogressbarheightsize = 12;
    static const componentSpinnersVideospinnersize = 80;
    static const componentSpinnersVideospinnersize0_5x = 40;
    static const componentSpinnersVideospinnerstrokesize = 4;
    /** Tab labels font size remain constant at 16px across devices and breakpoints. This behavior can be seen on the Mein Konto page tabs for purchases and payment data. */
    static const componentTabsTablabelfontsize = 16;
    /** Tab labels font size remain constant at 16px across devices and breakpoints. This behavior can be seen on the Mein Konto page tabs for purchases and payment data. */
    static const componentTabsTablabelfontsizeline = 16;
    static const componentTabsIostabbarheightsize = 49;
    static const componentTabsAndroidtabbarheightsize = 74;
    /** Tab labels font size remain constant at 16px across devices and breakpoints. This behavior can be seen on the Mein Konto page tabs for purchases and payment data. */
    static const componentTabsAppstabslabelfontsize = 16;
    /** Tab labels font size remain constant at 16px across devices and breakpoints. This behavior can be seen on the Mein Konto page tabs for purchases and payment data. */
    static const componentTabsAppstabslabellineheight = 23.4;
    static const componentTabsTopbartabitemheightsize = 44;
    static const componentTableTablecolumnwidthsize0_5x = 48;
    static const componentTableTablecolumnwidthsize0_75x = 64;
    static const componentTableTablecolumnwidthsize1x = 96;
    static const componentTableTablecolumnwidthsize1_5x = 160;
    static const componentTableTablecolumnwidthsize2x = 180;
    static const componentTableTablecolumnwidthsize2_5x = 240;
    static const componentTableTablecolumnwidthsize3x = 280;
    static const componentTableTableitemmaxwidthsize = 224;
    /** 16 - 16 - 22 - 24 This variable references the semantic variables kicker3fontsize and kicker2fontsize. At the 600px breakpoint smaller devices use the kicker3 variable */
    static const componentTeaserAteaserAteaserkickerfontsize = 18;
    static const componentTeaserAteaserAteaserkickerlineheight = 18;
    /** This variable references the semantic variables headline3 (XS&SM) and headline2 (MD&LG). 28 - 28 - 48 - 64 */
    static const componentTeaserAteaserAteaserheadlinefontsize = 36;
    static const componentTeaserAteaserAteaserheadlinelineheight = 39.6;
    static const componentTeaserAteaserAteasertitleinlinespace = 12;
    static const componentTeaserBteaserBteasertitleinlinespace = 8;
    static const componentTeaserBildplayBildplayteaserwidthsize = 169;
    /** XS-headline4FontSize:22 // SM-headline4FontSize:22 // MD-headline3FontSize:36 // LG-headline3FontSize:40 */
    static const componentTeaserMqteaserMqteaserheadlinefontsize = 26;
    static const componentTeaserMqteaserMqteaserheadlinelineheight = 28.6;
    static const componentTeaserMqteaserMqteaserheadlinefontweight = 700;
    static const componentTeaserMqteaserMqteasertitleinlinespace = 8;
    /** This token is for controling the height of badges that are inside of teasers. 32 - 32 - 32 - 40 */
    static const componentTeaserTeaserbadgesheightsizelg = 32;
    static const componentTeaserTeaserbadgesheightsizesm = 32;
    /** This variable is used for creating space around the outside of a subscription badge or video icon badge. */
    static const componentTeaserTeaserbadgesmarginspace = 8;
    static const componentTeaserTeaserkickerbginlinespace = 6;
    static const componentTeaserTeaserkickerbgstackspace = 2;
    static const componentTeaserQteaserQuadkickerfontsize = 18;
    /** This component level variable is used on the quad teaser headline. It references the semantic level variable headline1. 48 - 48 - 72 - 100 */
    static const componentTeaserQteaserQuadheadlinefontsize = 54;
    static const componentTeaserQteaserQuadheadlinelineheight = 56.7;
    static const componentTeaserQteaserQteasertitleinlinespace = 16;
    static const componentTeaserTeaserlayoutgridspace = 12;
    /** This variable is used for creating space around the outside of a subscription badge or video icon badge. */
    static const componentTeaserStdteaserStdteaserbadgesmarginspace = 8;
    static const componentTeaserStdteaserStdteaserimagetitlegapspace = 6;
    /** 2 | 2 | 2 | 2 - This variable is used on the standard teaser vertical spacing between the kicker and the headline. It references the semantic variable stackSpaceConst3XS */
    static const componentTeaserStdteaserStdteaserkickerheadlinestackspace = 2;
    /** 16 - 16 - 16 - 16 */
    static const componentTeaserSuperaSuperateasertitleinlinespace = 16;
    static const componentTeaserTeasertitleinlineleftspace = 0;
    static const componentTeaserTeasertitlestackspace = 4;
    static const componentTeaserTeasertitlegapspace = 4;
    static const componentTeaserTeasertitlebottomstackspace = 16;
    /** This variable is used on labels in list items with toggle switches found in app preferences. 14 - 14 - 16 - 18 */
    static const componentToggleswitchApptoggleitemlabelfontsize = 16;
    /** This variable is used on labels in list items with toggle switches found in app preferences. 14.1 - 14.1 - 16.2 - 18.2 */
    static const componentToggleswitchApptoggleitemlabellineheight = 16.2;
    static const componentVideoVideobadgetimelineheight = 23.8;
    /** 16 - 16 - 18 - 18 -- This variable is used to control the videoTimeBadge text style's font size parameter. The typography style that uses this variable is the videoTimeBadge style. The badge that uses this variable appears on the upper right corner of horizontal videos. */
    static const componentVideoVideotimebadgefontsize = 18;
    static const componentVideoVerticalvideomockheadlinefontsize = 32;
    static const componentVideoVideoframeinlinespace = 12;
    /** This variable is used for changing the red play icon inside the white square. */
    static const componentVideoVideoredplayiconheightsize = 14;
    static const componentVideoVideoredplayiconwidthsize = 12;
    static const componentVideoVideoskeletoncontainerheight = 464;
    /** 24 - 24 - 32 - 40 - This variable is used on horizontal video badges that contain a red play icon on top of a white square next to a timestamp. */
    static const componentVideoVideotimebadgesize = 32;
    /** This variable is used on video player badges that display a red play icon on top of a white square next to a time stamp. This variable references the borderRadiusXS. Constant value of 2 across device sizes. */
    static const componentVideoVideotimebadgecornersize = 2;
    /** 14 - 14 - 16 - 16 -- This variable is used in the videoAdBadge font size parameter. */
    static const componentVideoVideoadbadgefontsize = 16;
    /** This variable is used only for texts and labels that form part of this design system's documentation. */
    static const component_dsysdocsSpecsfontfamily = "Gotham";
    /** This variable is used only for this design system's component tests. */
    static const component_dsysdocs1columnmobile = 930;
    static const component_dsysdocsDsysdocswidthsize = 962;
    /** This variable is used in documentation pages that have small caption or lables along with a UI component documented. 4 - 4 - 6 - 8 */
    static const component_dsysdocsDscaptionstackspace0_5x = 6;
    static const component_dsysdocsDscaptionstackspace1x = 12;
    /** This variable is used on documentation pages. This is an alternative variable to the main container max width variable. 0 - 0 - 68 - 68 */
    static const component_dsysdocsDsmaincontainerspace = 68;
    /** This variable is used on documentation pages that have an artistic banner at the top of the page that is related to the foundation topic on the page. 80 - 80 -80 - 140 */
    static const component_dsysdocsFoundationsbannerheightsize = 80;
    /** This variable is used as a max width size for content blocks. For mobile devices this var references the DSysDocsWidthSize var 320 - 750 - 962 - 1024 */
    static const component_dsysdocsMaincontentstagesize = 962;
    /** This variable is currently used on a thin gallery that appears on desktop websites with petbook and other "books" content. Its height changes to a large height on mobile sites. 558 - 558 - 558 - 186 */
    static const component_dsysdocsThinbannerverticalheightsize = 558;
    /** Variable used in spacing parameters of bild.design webpage mockups. move to bild.design group maybe */
    static const component_dsysdocsBilddesignframespace = 64;
    /** This variable is used on documentation headers that contain info about platfroms and component names. 144 - 144 - 160 - 180 */
    static const component_dsysdocsDocheaderheightsize = 160;
    static const breakpointname = "md";
}
