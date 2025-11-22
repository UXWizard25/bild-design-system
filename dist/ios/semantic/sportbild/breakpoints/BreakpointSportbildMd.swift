
//
// BreakpointSportbildMd.swift
//

// Do not edit directly, this file was auto-generated.


import UIKit

public class BreakpointSportbildMd {
    /** 0-0-0-0 – no corner rounding. Used as default for flat layouts, content modules, images, and teaser elements. */
    public static let SemanticBorderBorderRadiusBorderRadiusNone = 0
    /** 2-2-2-2 use for corner rounding on very small UI elements such as tooltips and badges. */
    public static let SemanticBorderBorderRadiusBorderRadiusXS = 2
    /** 4-4-4-4 – use for corner rounding on compact components like checkboxes or small input controls. */
    public static let SemanticBorderBorderRadiusBorderRadiusSM = 4
    /** 8-8-8-8 – Standard radius for buttons, chips, input fields, and medium-sized interactive elements. */
    public static let SemanticBorderBorderRadiusBorderRadiusMD = 8
    /** 16-16-16-16 – use for corner rounding on small cards, overlays, and modal surfaces. */
    public static let SemanticBorderBorderRadiusBorderRadiusLG = 16
    /** 24-24-24-24 – use for corner rounding on larger cards, overlays, dialogs, and other container components. */
    public static let SemanticBorderBorderRadiusBorderRadiusXL = 24
    /** creates fully rounded shapes, typically used for circular elements like avatars. */
    public static let SemanticBorderBorderRadiusBorderRadiusFull = 9999
    /** 0.33 -0.33 -0.33 -0.33 – primarily used in mobile app interfaces. Optimized for high-density displays to create subtle dividers and outlines without visual overload. */
    public static let SemanticBorderBorderWidthBorderWidthHairline = 0.33
    /** 1-1-1-1 – use for subtle outlines and dividers */
    public static let SemanticBorderBorderWidthBorderWidthThin = 1
    /** 2-2-2-2 – use for stronger outlines on form elements (inputs), buttons (outline variants), and interaction states (focus, hover, active) */
    public static let SemanticBorderBorderWidthBorderWidthThick = 2
    /** Common viewport width size based on the selected breakpoint.
Apply this token to the main frame of page layouts. */
    public static let SemanticLayoutCanvasWidthSizeWeb = 600
    /** Common viewport height size based on the selected mode.
Apply this token to the main frame of page layouts to simulate realistic vertical space. */
    public static let SemanticLayoutCanvasHeightSizeWeb = 960
    /** Common viewport width size based on the selected breakpoint.
Apply this token to the main frame of page layouts. */
    public static let SemanticLayoutCanvasWidthSizeApp = 834
    /** Common viewport height size based on the selected mode.
Apply this token to the main frame of page layouts to simulate realistic vertical space. */
    public static let SemanticLayoutCanvasHeightSizeApp = 1194
    /** 320 - 390 - 600 - 1024 – Defines the minimum width of the main frame for different breakpoints.
Apply this token to the main frame of page layouts to simulate realistic minimum widths across responsive viewports. */
    public static let SemanticLayoutBreakpointsBreakpointMinWidthSize = 600
    /** 389 - 599 - 1023 - 1024 – Defines the minimum width of the main frame for different breakpoints.
Apply this token to the main frame of page layouts to simulate realistic maximum widths across responsive viewports. */
    public static let SemanticLayoutBreakpointsBreakpointMaxWidthSize = 1023
    /** Use for content containers that should not fill the full page width on larger viewports. This is commonly used on article body text content and other elements in an article page. */
    public static let SemanticLayoutContentWidthContentMaxWidthMedium = 700
    /** Use for content containers that should fill the full width of the page */
    public static let SemanticLayoutContentWidthContentMaxWidthFull = 1024
    /** 6-6-6-8 – use for side paddings and gutters in responsive layouts */
    public static let SemanticLayoutGridResponsiveGridSpaceRespSM = 6
    /** 12-12-12-16 – use for side paddings and gutters in responsive layouts */
    public static let SemanticLayoutGridResponsiveGridSpaceRespBase = 12
    /** 24-24-32-32 – use for side paddings and gutters in responsive layouts */
    public static let SemanticLayoutGridResponsiveGridSpaceRespLG = 32
    /** 48-48-64-64 – use for side paddings and gutters in responsive layouts */
    public static let SemanticLayoutGridResponsiveGridSpaceRespXL = 64
    /** 0-0-0-16 – This token is used on the main homepages content container, ensuring full-width layout (no horizontal padding) on mobile and tablet breakpoints. */
    public static let SemanticLayoutGridResponsivePageInlineSpace = 0
    /** 12-12-12-12 – use for fixed side paddings and gutters */
    public static let SemanticLayoutGridConstantGridSpaceConstSM = 12
    /** 16-16-16-16 – use for fixed side paddings and gutters */
    public static let SemanticLayoutGridConstantGridSpaceConstLG = 16
    /** Used to set the column count in Figma Layout guide Grids */
    public static let SemanticLayoutGridLayoutGuideLayoutGuideGridColums = 8
    /** 24-24-36-36 – Use for vertical spacing between subsections in a layout */
    public static let SemanticLayoutSectionSectionSpaceSM = 36
    /** 36-36-48-48 – Use for vertical spacing between sections in a layout. */
    public static let SemanticLayoutSectionSectionSpaceBase = 48
    /** 72-72-96-96 – Use for vertical spacing between sections in a layout */
    public static let SemanticLayoutSectionSectionSpaceLG = 96
    /** 16-16-32-32 – Use for spacing after paragraphs in text content */
    public static let SemanticLayoutSectionParagraphEndSpace = 32
    /** 2-2-4-6 – Use for gaps between items inside of UI elements that scale across breakpoints */
    public static let SemanticSpaceGapResponsiveGapSpaceResp2XS = 4
    /** 4-4-6-8 – Use for gaps between items inside of UI elements that scale across breakpoints */
    public static let SemanticSpaceGapResponsiveGapSpaceRespXS = 6
    /** 8-8-12-16 – Use for gaps between items inside of UI elements that scale across breakpoints */
    public static let SemanticSpaceGapResponsiveGapSpaceRespSM = 12
    /** 12-12-16-24 – Use for gaps between items inside of UI elements that scale across breakpoints */
    public static let SemanticSpaceGapResponsiveGapSpaceRespMD = 16
    /** 16-16-24-32 – Use for gaps between items inside of UI elements that scale across breakpoints */
    public static let SemanticSpaceGapResponsiveGapSpaceRespLG = 24
    /** 24-24-32-48 – Use for gaps between items inside of UI elements that scale across breakpoints */
    public static let SemanticSpaceGapResponsiveGapSpaceRespXL = 32
    /** 32-32-48-64 – Use for gaps between items inside of UI elements that scale across breakpoints */
    public static let SemanticSpaceGapResponsiveGapSpaceResp2XL = 48
    /** 48-48-72-96 – Use for gaps between items inside of UI elements that scale across breakpoints */
    public static let SemanticSpaceGapResponsiveGapSpaceResp3XL = 72
    /** 2-2-2-2 – Use for fixed gaps between items inside of UI elements */
    public static let SemanticSpaceGapConstantGapSpaceConst2XS = 2
    /** 4-4-4-4 – Use for fixed gaps between items inside of UI elements */
    public static let SemanticSpaceGapConstantGapSpaceConstXS = 4
    /** 8-8-8-8 – Use for fixed gaps between items inside of UI elements */
    public static let SemanticSpaceGapConstantGapSpaceConstSM = 8
    /** 12-12-12-12 – Use for fixed gaps between items inside of UI elements */
    public static let SemanticSpaceGapConstantGapSpaceConstMD = 12
    /** 16-16-16-16 – Use for fixed gaps between items inside of UI elements */
    public static let SemanticSpaceGapConstantGapSpaceConstLG = 16
    /** 24-24-24-24 – Use for fixed gaps between items inside of UI elements */
    public static let SemanticSpaceGapConstantGapSpaceConstXL = 24
    /** 32-32-32-32 – Use for fixed gaps between items inside of UI elements */
    public static let SemanticSpaceGapConstantGapSpaceConst2XL = 32
    /** 48-48-48-48 – Use for fixed gaps between items inside of UI elements */
    public static let SemanticSpaceGapConstantGapSpaceConst3XL = 48
    /** 8-8-12-16 – use for horizontal (left/right) padding of UI elements that scales across breakpoints */
    public static let SemanticSpaceInlineResponsiveInlineSpaceRespSM = 12
    /** 12-12-16-24 use for horizontal (left/right) padding of UI elements that scales across breakpoints */
    public static let SemanticSpaceInlineResponsiveInlineSpaceRespMD = 16
    /** 16-16-24-32 – use for horizontal (left/right) padding of UI elements that scales across breakpoints */
    public static let SemanticSpaceInlineResponsiveInlineSpaceRespLG = 24
    /** 24-24-32-40 – use for horizontal (left/right) padding of UI elements that scales across breakpoints */
    public static let SemanticSpaceInlineResponsiveInlineSpaceRespXL = 32
    /** 32-32-48-64 – use for horizontal (left/right) padding of UI elements that scales across breakpoints */
    public static let SemanticSpaceInlineResponsiveInlineSpaceResp2XL = 48
    /** 2-2-2-2 – Use for fixed horizontal (left/right) padding of UI elements */
    public static let SemanticSpaceInlineConstantInlineSpaceConst3XS = 2
    /** 4-4-4-4 – Use for fixed horizontal (left/right) padding of UI elements */
    public static let SemanticSpaceInlineConstantInlineSpaceConst2XS = 4
    /** 6-6-6-6 – Use for fixed horizontal (left/right) padding of UI elements */
    public static let SemanticSpaceInlineConstantInlineSpaceConstXS = 6
    /** 8-8-8-8 – Use for fixed horizontal (left/right) padding of UI elements */
    public static let SemanticSpaceInlineConstantInlineSpaceConstSM = 8
    /** 12-12-12-12 – Use for fixed horizontal (left/right) padding of UI elements */
    public static let SemanticSpaceInlineConstantInlineSpaceConstMD = 12
    /** 16-16-16-16 – Use for fixed horizontal (left/right) padding of UI elements */
    public static let SemanticSpaceInlineConstantInlineSpaceConstLG = 16
    /** 24-24-24-24 – Use for fixed horizontal (left/right) padding of UI elements */
    public static let SemanticSpaceInlineConstantInlineSpaceConstXL = 24
    /** 32-32-32-32 – Use for fixed horizontal (left/right) padding of UI elements */
    public static let SemanticSpaceInlineConstantInlineSpaceConst2XL = 32
    /** 8-8-12-16 – use for vertical (top/bottom) padding of UI elements that scales across breakpoints */
    public static let SemanticSpaceStackResponsiveStackSpaceRespSM = 12
    /** 12-12-16-24 – use for vertical (top/bottom) padding of UI elements that scales across breakpoints */
    public static let SemanticSpaceStackResponsiveStackSpaceRespMD = 16
    /** 16-16-24-32 – use for vertical (top/bottom) padding of UI elements that scales across breakpoints */
    public static let SemanticSpaceStackResponsiveStackSpaceRespLG = 24
    /** 24-24-32-40 – use for vertical (top/bottom) padding of UI elements that scales across breakpoints */
    public static let SemanticSpaceStackResponsiveStackSpaceRespXL = 32
    /** 32-32-48-64 – use for vertical (top/bottom) padding of UI elements that scales across breakpoints */
    public static let SemanticSpaceStackResponsiveStackSpaceResp2XL = 48
    /** 2-2-2-2 – Use for fixed vertical (top/bottom) padding of UI elements */
    public static let SemanticSpaceStackConstantStackSpaceConst3XS = 2
    /** 4-4-4-4 – Use for fixed vertical (top/bottom) padding of UI elements */
    public static let SemanticSpaceStackConstantStackSpaceConst2XS = 4
    /** 6-6-6-6 – Use for fixed vertical (top/bottom) padding of UI elements */
    public static let SemanticSpaceStackConstantStackSpaceConstXS = 6
    /** 8-8-8-8 – Use for fixed vertical (top/bottom) padding of UI elements */
    public static let SemanticSpaceStackConstantStackSpaceConstSM = 8
    /** 12-12-12-12 – Use for fixed vertical (top/bottom) padding of UI elements */
    public static let SemanticSpaceStackConstantStackSpaceConstMD = 12
    /** 16-16-16-16 – Use for fixed vertical (top/bottom) padding of UI elements */
    public static let SemanticSpaceStackConstantStackSpaceConstLG = 16
    /** 24-24-24-24 – Use for fixed vertical (top/bottom) padding of UI elements */
    public static let SemanticSpaceStackConstantStackSpaceConstXL = 24
    /** 32-32-32-32 – Use for fixed vertical (top/bottom) padding of UI elements */
    public static let SemanticSpaceStackConstantStackSpaceConst2XL = 32
    /** 12-12-14-16 – Use for setting height and width of UI elements that scale across breakpoints */
    public static let SemanticSizeResponsiveSizeResp4XS = 14
    /** 16-16-16-24 – Use for setting height and width of UI elements that scale across breakpoints */
    public static let SemanticSizeResponsiveSizeResp3XS = 16
    /** 24-24-32-32 – Use for setting height and width of UI elements that scale across breakpoints */
    public static let SemanticSizeResponsiveSizeResp2XS = 32
    /** 32-32-40-48 – Use for setting height and width of UI elements that scale across breakpoints */
    public static let SemanticSizeResponsiveSizeRespXS = 40
    /** 40-40-48-56 – Use for setting height and width of UI elements that scale across breakpoints */
    public static let SemanticSizeResponsiveSizeRespSM = 48
    /** 48-48-64-72 – Use for setting height and width of UI elements that scale across breakpoints */
    public static let SemanticSizeResponsiveSizeRespMD = 64
    /** 56-56-72-92 – Use for setting height and width of UI elements that scale across breakpoints */
    public static let SemanticSizeResponsiveSizeRespLG = 72
    /** 64-64-80-96 – Use for setting height and width of UI elements that scale across breakpoints */
    public static let SemanticSizeResponsiveSizeRespXL = 80
    /** 72-72-92-100 – Use for setting height and width of UI elements that scale across breakpoints */
    public static let SemanticSizeResponsiveSizeResp2XL = 92
    /** 96-96-120-148 – Use for setting height and width of UI elements that scale across breakpoints */
    public static let SemanticSizeResponsiveSizeResp3XL = 120
    /** 148-148-160-180 – Use for setting height and width of UI elements that scale across breakpoints */
    public static let SemanticSizeResponsiveSizeResp4XL = 160
    /** 8-8-8-8 – Use for setting fixed height and width of UI elements */
    public static let SemanticSizeConstantSizeConst4XS = 8
    /** 16-16-16-16 – Use for setting fixed height and width of UI elements */
    public static let SemanticSizeConstantSizeConst3XS = 16
    /** 24-24-24-24 – Use for setting fixed height and width of UI elements */
    public static let SemanticSizeConstantSizeConst2XS = 24
    /** 32-32-32-32 – Use for setting fixed height and width of UI elements */
    public static let SemanticSizeConstantSizeConstXS = 32
    /** 40-40-40-40 – Use for setting fixed height and width of UI elements */
    public static let SemanticSizeConstantSizeConstSM = 40
    /** 48-48-48-48 Use for setting fixed height and width of UI elements */
    public static let SemanticSizeConstantSizeConstMD = 48
    /** 56-56-56-56 – Use for setting fixed height and width of UI elements */
    public static let SemanticSizeConstantSizeConstLG = 56
    /** 64-64-64-64 – Use for setting fixed height and width of UI elements */
    public static let SemanticSizeConstantSizeConstXL = 64
    /** 72-72-72-72 – Use for setting fixed height and width of UI elements */
    public static let SemanticSizeConstantSizeConst2XL = 72
    /** 96-96-96-96 – Use for setting fixed height and width of UI elements */
    public static let SemanticSizeConstantSizeConst3XL = 96
    /** 148-148-148-148 – Use for setting fixed height and width of UI elements */
    public static let SemanticSizeConstantSizeConst4XL = 148
    /** This variable references the bodyFontFamily variable from the branding collection. */
    public static let SemanticTypographyFontFamilyBodyFontFamily = "Inter"
    public static let SemanticTypographyFontFamilyCalloutFontFamily = "AntennaCond"
    public static let SemanticTypographyFontFamilyDisplayFontFamily = "AntennaCond"
    public static let SemanticTypographyFontFamilyFootnoteFontFamily = "Inter"
    public static let SemanticTypographyFontFamilyHeadlineFontFamily = "AntennaExtraCond"
    public static let SemanticTypographyFontFamilyKickerFontFamily = "AntennaExtraCond"
    public static let SemanticTypographyFontFamilyLabelFontFamily = "AntennaExtraCond"
    public static let SemanticTypographyFontFamilySubheadlineFontFamily = "AntennaCond"
    public static let SemanticTypographyFontFamilyTitleFontFamily = "AntennaCond"
    public static let SemanticTypographyFontFamilyQuoteFontFamily = "AntennaCond"
    /** This variable is used on the body text style's font size parameter. It remains constant at 21. */
    public static let SemanticTypographyFontSizeBodyBodyFontSize = 17
    /** This token is used for the font size parameter of the callout text style. 18 - 18 - 22 - 22 */
    public static let SemanticTypographyFontSizeCalloutCallout1FontSize = 24
    /** This variable is used on the font size parameter for the display1 text style. 40 - 40 - 72 - 120 */
    public static let SemanticTypographyFontSizeDisplayDisplay1FontSize = 68
    /** This variable is used for the font size parameter of the Display2 text style. 36 - 36 - 42 - 64 */
    public static let SemanticTypographyFontSizeDisplayDisplay2FontSize = 40
    /** This variable is used on the display3 font size parameter of the display3 text style. 28 - 28 - 32 - 40 */
    public static let SemanticTypographyFontSizeDisplayDisplay3FontSize = 30
    /** This token is used on the footnote text style font size parameter. 16 - 16 - 16 - 18 */
    public static let SemanticTypographyFontSizeFootnoteFootnote1FontSize = 13
    /** This token is used in the font size parameter of the footnote2 text style. 12 - 12 - 12 - 16 */
    public static let SemanticTypographyFontSizeFootnoteFootnote2FontSize = 10
    /** This token is used for the headline1 text style's font size parameter. 48 - 48 - 72 - 100 */
    public static let SemanticTypographyFontSizeHeadlineHeadline1FontSize = 60
    /** This token is used on the headline2 text style's font size parameter. 40 - 40 - 48 - 64 */
    public static let SemanticTypographyFontSizeHeadlineHeadline2FontSize = 44
    /** This token is used on the headline3 text style's font size parameter. 28 - 28 - 36 - 40 */
    public static let SemanticTypographyFontSizeHeadlineHeadline3FontSize = 30
    /** This token controls the headline4 text style's font size parameter: 22 - 22 - 26 - 32 */
    public static let SemanticTypographyFontSizeHeadlineHeadline4FontSize = 26
    /** Values come from NMT Figma File 01_Foundation; in online CSS this is kicker0. 18 - 18 - 22 - 30 - This variable does not exist yet in online css. Online css is called kicker0 for smallest font size. */
    public static let SemanticTypographyFontSizeKickerKicker1FontSize = 26
    /** Values come from comparing NMT Figma File 01_Foundation to online CSS. Online kickers are numbered from 0 to 3. This DS uses 1 to 4 following html convention of h1, h2, h3, etc. 18 - 18 - 22 - 24 */
    public static let SemanticTypographyFontSizeKickerKicker2FontSize = 26
    /** Values come from comparing NMT Figma File 01_Foundation to online CSS. Online kickers are numbered from 0 to 3. 16 - 16 - 18 - 20 */
    public static let SemanticTypographyFontSizeKickerKicker3FontSize = 20
    /** Values come from comparing NMT Figma File 01_Foundation to online CSS. Online kickers are numbered from 0 to 3. 14 - 14 - 16 - 16 */
    public static let SemanticTypographyFontSizeKickerKicker4FontSize = 16
    /** This token is used in the label1 text style font size parameter. Its value remains constant at 17 across device sizes. */
    public static let SemanticTypographyFontSizeLabelLabel1FontSize = 17
    /** 10 - 10 - 15 - 17 Use this label font size when you want your label's font size to change across device sizes. */
    public static let SemanticTypographyFontSizeLabelLabel1FontSizeResponsive = 15
    /** This variable controls the label2 text style's font size parameter. Its value remains constant at 15. */
    public static let SemanticTypographyFontSizeLabelLabel2FontSize = 15
    /** This token is used in the label3 text style's font size parameter. Its value remains constant at 12 across device sizes. */
    public static let SemanticTypographyFontSizeLabelLabel3FontSize = 12
    /** This token is used in the font size parameter of the label4 text style. The value remains constant at 8. */
    public static let SemanticTypographyFontSizeLabelLabel4FontSize = 8
    /** This token controls the subheadline1 font size parameter. 24 - 24 - 32 - 36 */
    public static let SemanticTypographyFontSizeSubheadlineSubheadline1FontSize = 22
    /** 22 - 22 - 22 - 28 -- html class stage-block-title__text css var --ressort-header-font-size(sm-md-lg) */
    public static let SemanticTypographyFontSizeTitleTitle1FontSize = 28
    /** 16 - 16 - 18 - 20 - html class stage-block-title__text css var --ressort-header-font-size(sm-md-lg) */
    public static let SemanticTypographyFontSizeTitleTitle2FontSize = 18
    /** 16 - 16 - 18 - 20 -- This variable is used for controlling the font size of the quote text style. */
    public static let SemanticTypographyFontSizeQuoteQuoteFontSize = 18
    public static let SemanticTypographyFontWeightBodyBodyFontWeightBook = 400
    public static let SemanticTypographyFontWeightBodyBodyFontWeightBold = 700
    public static let SemanticTypographyFontWeightCalloutCalloutFontWeight = 800
    public static let SemanticTypographyFontWeightDisplayDisplayFontWeight = 800
    public static let SemanticTypographyFontWeightFootnoteFootnoteFontWeightBold = 700
    public static let SemanticTypographyFontWeightFootnoteFootnoteFontWeightBook = 400
    public static let SemanticTypographyFontWeightHeadlineHeadline1FontWeight = 700
    /** This variable is a string type variable for controlling not only headline font weight but also the italic style for Sport Bild headlines. */
    public static let SemanticTypographyFontWeightHeadlineHeadline1FontWeightST = "Bold Italic"
    public static let SemanticTypographyFontWeightHeadlineHeadline2FontWeight = 700
    public static let SemanticTypographyFontWeightHeadlineHeadline3FontWeight = 700
    public static let SemanticTypographyFontWeightHeadlineHeadline4FontWeight = 700
    public static let SemanticTypographyFontWeightKickerKickerFontWeight = 700
    public static let SemanticTypographyFontWeightKickerKickerFontWeightST = "Black Italic"
    public static let SemanticTypographyFontWeightLabelLabelFontWeightBook = 400
    public static let SemanticTypographyFontWeightLabelLabelFontWeightBold = 700
    public static let SemanticTypographyFontWeightSubheadlineSubheadlineFontWeight = 700
    public static let SemanticTypographyFontWeightTitleTitleFontWeight = 800
    public static let SemanticTypographyFontWeightQuoteQuoteFontWeight = 800
    /** Figma's font line height currently does not allow for multipliers as is used on current website css var(--body-line-height) */
    public static let SemanticTypographyLineHeightBodyBodyLineHeight = 29.75
    public static let SemanticTypographyLineHeightCalloutCalloutLineHeight = 31.2
    public static let SemanticTypographyLineHeightDisplayDisplay1LineHeight = 72
    public static let SemanticTypographyLineHeightDisplayDisplay2LineHeight = 42
    public static let SemanticTypographyLineHeightDisplayDisplay3LineHeight = 32
    public static let SemanticTypographyLineHeightFootnoteFootnote1LineHeight = 17.03
    public static let SemanticTypographyLineHeightFootnoteFootnote2LineHeight = 13
    public static let SemanticTypographyLineHeightHeadlineHeadline1LineHeight = 69
    public static let SemanticTypographyLineHeightHeadlineHeadline2LineHeight = 50.6
    public static let SemanticTypographyLineHeightHeadlineHeadline3LineHeight = 34.5
    public static let SemanticTypographyLineHeightHeadlineHeadline4LineHeight = 28.6
    public static let SemanticTypographyLineHeightKickerKicker1LineHeight = 28.6
    public static let SemanticTypographyLineHeightKickerKicker2LineHeight = 28.6
    public static let SemanticTypographyLineHeightKickerKicker3LineHeight = 22
    public static let SemanticTypographyLineHeightKickerKicker4LineHeight = 17.6
    /** This variable is used in the label1 text style's line height parameter. It references branding variables for brand specific line heights. */
    public static let SemanticTypographyLineHeightLabelLabel1LineHeight = 20.4
    public static let SemanticTypographyLineHeightLabelLabel1ResponsiveLineHeight = 18
    public static let SemanticTypographyLineHeightLabelLabel2LineHeight = 19.2
    public static let SemanticTypographyLineHeightLabelLabel3LineHeight = 14.4
    public static let SemanticTypographyLineHeightLabelLabel4LineHeight = 10
    public static let SemanticTypographyLineHeightSubheadlineSubheadline1LineHeight = 28.6
    public static let SemanticTypographyLineHeightTitleTitle1LineHeight = 30.8
    /** html class stage-block-title__text css var --ressort-header-font-size(sm-md-lg) */
    public static let SemanticTypographyLineHeightTitleTitle2LineHeight = 23.4
    /** This variable is used in the quote text style line height parameter. */
    public static let SemanticTypographyLineHeightQuoteQuoteLineHeight = 23.4
    /** 2 | 2 | 2 | 3 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. */
    public static let SemanticTypographyLetterSpacingLetterSpacingPositiveLG = 2
    /** 1 | 1 | 1 | 1 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. */
    public static let SemanticTypographyLetterSpacingLetterSpacingPositiveMD = 1
    /** 0.5 | 0.5 | 0.5 | 0.5 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. */
    public static let SemanticTypographyLetterSpacingLetterSpacingPositiveSM = 0.5
    /** 0.25 | 0.25 | 0.25 | 0.25 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. */
    public static let SemanticTypographyLetterSpacingLetterSpacingPositiveXS = 0.25
    /** 0 | 0 | 0 | 0 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. */
    public static let SemanticTypographyLetterSpacingLetterSpacingNone = 0
    /** -0.25 | -0.25 | -0.25 | -0.25 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. This letter spacing was only found in large titles on iOS mobile app large title component. */
    public static let SemanticTypographyLetterSpacingLetterSpacingNegativeXS = -0.25
    /** -0.5 | -0.5 | -0.25 | -0.25 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. */
    public static let SemanticTypographyLetterSpacingLetterSpacingNegativeSM = -0.25
    /** -1 | -1 | -1 | -1 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. */
    public static let SemanticTypographyLetterSpacingLetterSpacingNegativeMD = -1
    /** -2 | -2 | -2 | -3 | This variable takes primitive letter spacing variables and creates this semantic variable for use on designs that change across device sizes. */
    public static let SemanticTypographyLetterSpacingLetterSpacingNegativeLG = -2
    /** -0.5 | -0.5 | -1 | -2 | This variable is used for the letter spacing parameter of the display1 text style. On smaller devices the value is smaller than on larger devices. On desktop devices the letter spacing is further reduced for making the text style more compact. */
    public static let SemanticTypographyLetterSpacingDisplayDisplay1LetterSpacing = -1
    /** -0.5 | -0.5 | -1 | -1 | This variable is used for the letter spacing parameter of the display2 text style. On smaller devices the value is smaller than on larger devices. */
    public static let SemanticTypographyLetterSpacingDisplayDisplay2LetterSpacing = -1
    /** -0.5 | -0.5 | -1 | -1 | This variable is used for the letter spacing parameter of the display3 text style. On smaller devices the value is smaller than on larger devices. */
    public static let SemanticTypographyLetterSpacingDisplayDisplay3LetterSpacing = -1
    /** Use for showing elements on desktop viewport sizes only */
    public static let SemanticVisibilityBooleanVisilbleDesktopOnly = false
    /** Use for showing elements on tablet viewport sizes only */
    public static let SemanticVisibilityBooleanVisilbleTabletOnly = true
    /** Use for showing elements on mobile viewport sizes only */
    public static let SemanticVisibilityBooleanVisilbleMobileOnly = false
    /** Use for showing elements on viewport sizes above 600 px */
    public static let SemanticVisibilityBooleanVisilbleAbove600px = true
    /** Use for showing elements on viewport sizes below 600 px */
    public static let SemanticVisibilityBooleanVisilbleBelow600px = false
    /** Use for hiding elements on desktop viewport sizes only */
    public static let SemanticVisibilityBooleanHideOnDesktop = true
    /** Use for hiding elements on mobile viewport sizes */
    public static let SemanticVisibilityBooleanHideOnMobile = true
    public static let SemanticVisibilityVariantSwitchBpSpecificWeb = "md"
    public static let SemanticVisibilityVariantSwitchBpSpecificApp = "regular"
    public static let SemanticVisibilityVariantSwitchChangeOnLG = "xs/sm/md"
    /** This variable is used for controlling size changes across device sizes on some components such as the vertical newsticker cards and the search results cards. Both have cards that change layouts at different breakpoints. */
    public static let SemanticVisibilityVariantSwitchChangeOnMD = "md/lg"
    /** This variable exists specifically for changing the accordion font family across brands. It is subject to review. Bild: GothamXNarrow, SpoBi: Inter, Ads: LucindaGrande */
    public static let ComponentAccordionAccordionLabelFontFamily = "Inter"
    /** This variable is used for setting the size of avatar images in article pages. It references the sizeConstMD variable from the "generic" semantic collection. Its value is 48 across devices. */
    public static let ComponentAvatarAvatarArticleSize = 48
    /** 96 - 96 - 130 - 130 This variable is used for controlling the size of the avatar image on author pages. */
    public static let ComponentAvatarAvatarAuthorPageSize = 130
    /** This variable is used on avatar names in article pages. Bild: 16 - 16 - 16 - 18; SpoBi&Ads: 13 - 13 - 13 - 15 */
    public static let ComponentAvatarAvatarLabelFontSize = 13
    /** This variable is used for controlling the line height of avatar texts. Its values influence the stacking space between avatar texts. 21 - 21 - 21 - 23 */
    public static let ComponentAvatarAvatarLabelLineHeight = 21
    /** This variable is used in avatar text styles. It receives values from the Brand Tokens Collection. Bild: GothamXNarrow; SpoBi: Inter; Ads: LucidaGrande */
    public static let ComponentAvatarAvatarFontFamily = "Inter"
    /** This variable is used for setting the inline space between multiple avatars that are horizontally placed in a lane when an article has multiple authors. 16 - 16 - 24 - 24 */
    public static let ComponentAvatarAvatarLaneGapSpace = 24
    /** This variable is used for setting the font of avatars on iOS and Android platforms. This is subject to review. */
    public static let ComponentAvatarAppAvatarFontFamily = "AntennaCond"
    /** This variable is used to control the font size of kickers in the heading section of article pages. 18 - 18 - 22 - 30 */
    public static let ComponentArticleArticleKickerFontSize = 26
    /** 40 - 40 - 72 - 100 - This variable uses the semantic variables headline2 for XS&SM, headline1 for MD&LG */
    public static let ComponentArticleArticleHeadlineFontSize = 60
    /** CSS --article-figure-meta-font-size 16-16-18-18 */
    public static let ComponentArticleArticleImageCaptionFontSize = 13
    /** this component level variable references the branding variables */
    public static let ComponentArticleArticleImageCaptionLineHeight = 16.9
    /** This variable is used on the font size of article day&time stamp that usually shows up along with the article author avatars. On app versions this variable is used for the avatar names. 12 - 12 - 14 - 16 */
    public static let ComponentArticleArticleMetaFontSize = 14
    /** This variable is used on the font size of article day&time stamp that usually shows up along with the article author avatars. On app versions this variable is used for the avatar names. This variable references variables from the branding collection. */
    public static let ComponentArticleArticleMetaFontFamily = "AntennaCond"
    /** 8 | 8 | 12 | 16 - This space variable is used at the top edge of the article main content bounding box. */
    public static let ComponentArticleArticleTopMarginSpace = 12
    public static let ComponentArticleAricleMobile1ColGridImageMarginSpace = 72
    /** 12 | 12 | 12 | 16 - This spacing variable is used for the space between article page heading kickers, headlines and subheadlines. XS&SM need review; correct value might be 8 */
    public static let ComponentArticleArticleHeadingsStackSpace = 12
    /** 16 | 16 | 72 | 16 - This variable is used for the left and right space within the article page headings container which holds the article page kicker, headline and subheadline. */
    public static let ComponentArticleArticleHeadingsInlineSpace = 72
    /** 16 - 16 - 24 - 32 - This variable creates the vertical spacing between different article body elements such as avatars, media players, corssheadings, paragraphs, field sets, images, tables, quotes, videos, social embeds, etc. */
    public static let ComponentArticleArticleContentStackSpace = 24
    /** 16 | 16 | 72 | 162 - This variable is used for making the left and right spacings around article content blocks. Current css has the article-body class assigned to a div and article body contains these horizontal padding values. */
    public static let ComponentArticleArticleContentInlineSpace = 72
    /** same as standard teaser width size variable */
    public static let ComponentArticleArticleGalleryATeaserWidth = 260
    /** NMT CSS --article-figure-meta-font-size */
    public static let ComponentArticleArticleImageSourceFontSize = 13
    public static let ComponentArticleArticleImageSourceLineHeight = 17
    public static let ComponentArticleArticleImageContainerStackSpace = 12
    public static let ComponentArticleArticleImageLandscapeInlineSpace = 12
    public static let ComponentArticleArticleImagePortaitInlineSpace = 72
    public static let ComponentArticleArticleInfoboxInlineSpace = 24
    public static let ComponentArticleArticleInfoboxStackSpace = 24
    /** This variable is used in the text style dedicated to audio player labels for elapsed time, reproduction speed and short functionality description text. 16 - 16 - 16 - 18 */
    public static let ComponentAudioPlayerAudioPlayerFontSize = 16
    /** 30 - 30 - 30 - 30 - This variable is used on the Advert rectangular badge that is found above an ad containers. */
    public static let ComponentBadgeAdLabelBadgeHeightSize = 30
    /** This space variable is used for creating the top and bottom space between a badge's text label and the surface that the text label is on top of. */
    public static let ComponentBadgeBadgesInnerStackSpace = 2
    /** This space variable is used for creating the left and right space between a badge's text label and the badge background surface that the text label is on top of. */
    public static let ComponentBadgeBadgesInnerInlineSpace = 4
    public static let ComponentBreadcrumbBreadcrumbFontFamily = "Inter"
    /** 15 - 15 - 15 - 12 -- Breadcrumbs have a slightly larger font size on mobile devices compared to when they are rendered on larger desktop devices. */
    public static let ComponentBreadcrumbBreadcrumbFontSize = 14
    /** 15 - 15 - 15 - 12 -- Breadcrumbs have a slightly larger font size on mobile devices compared to when they are rendered on larger desktop devices. */
    public static let ComponentBreadcrumbBreadcrumbLineHeight = 14
    public static let ComponentBreadcrumbBreadcrumb&ArrowLeftInlineSpace1 = 3
    public static let ComponentBreadcrumbBreadcrumb&ArrowRightInlineSpace2 = 5
    public static let ComponentBreadcrumbBreadcrumbInlineSpace = 12
    public static let ComponentBreadcrumbBreadcrumbFontWeight = 400
    public static let ComponentBreadcrumbBreadcrumbStackSpace = 14
    public static let ComponentBreakingNewsBreakingNewsContainerHeightSize = 56
    public static let ComponentBreakingNewsBreakingNewsBadgeInlineSpace = 12
    public static let ComponentBreakingNewsBreakingNewsBadgeTitelsStackSpace = 4
    public static let ComponentBreakingNewsBreakingNewsBadgeUpperTitleFontSize = 17
    public static let ComponentBreakingNewsBreakingNewsBadgeUpperTitleLineHeight = 12
    public static let ComponentBreakingNewsBreakingNewsBadgeLowerTitleFontSize = 30
    public static let ComponentBreakingNewsBreakingNewsBadgeLowerTitleLineHeight = 21
    public static let ComponentBreakingNewsBreakingNewsScrollingTextFontSize = 21
    public static let ComponentBreakingNewsBreakingNewsScrollingTextLineHeight = 24
    public static let ComponentButtonButtonLabelFontSize = 15
    public static let ComponentButtonButtonLabelLineHeight = 15
    public static let ComponentButtonButtonContentGapSpace = 6
    public static let ComponentButtonButtonInlineSpace = 16
    public static let ComponentButtonButtonStackSpace = 6
    public static let ComponentButtonButtonBorderWidthSize = 2
    /** This fixed height variable ensures that the button maintains a consistent height, even when the icon is not active. */
    public static let ComponentButtonButtonContentMinHeightSize = 24
    /** Use this variable for controlling the font size of partner buttons. 16 - 16 - 16 - 18 */
    public static let ComponentButtonPartnerLinkButtonLabelFontSize = 16
    public static let ComponentButtonPartnerLinkButtonInlineSpace = 8
    public static let ComponentButtonPartnerLinkButtonLabelHeightSize = 48
    public static let ComponentButtonButtonBorderRadius = 8
    public static let ComponentCardsSearchResultCardImageWidthSize = 216
    public static let ComponentCardsSearchResultCardImageHeightSizeStacked = 189
    public static let ComponentCardsNewstickerImageCardWidthSize = 206
    /** This token is used to create more bottom padding space on system teaser headlines inside the gallery to avoid overlapping with the pagination. */
    public static let ComponentCarouselGalleryTeaserTitleBottomSpace = 36
    /** This token is used to create more bottom padding space on system teaser headlines inside the gallery to avoid overlapping with the pagination. */
    public static let ComponentCarouselGalleryTeaserAppGapSpace = 8
    public static let ComponentCarouselAppEpaperCarouselItemDefaultWidth = 172
    public static let ComponentCarouselAppEpaperCarouselItemFocusWidth = 240
    public static let ComponentCarouselAppEpaperCarouseBeilageItemWidth = 172
    public static let ComponentCarouselStandardTeaserGalleryTeaserWidthWeb = 260
    public static let ComponentCarouselStandardTeaserGalleryTeaserWidthApp = 280
    /** This variable is used on the chips font size parameter of the chips text style. The font size changes only for the change between larger device widths and any device smaller than the largest. 16 - 16 -16 - 18 */
    public static let ComponentChipsChipsFontSize = 16
    public static let ComponentChipsChipsInlineSpace = 12
    public static let ComponentChipsChipsStackSpace = 8
    public static let ComponentDatepickerDatepickerItemDayWidthSize = 44
    public static let ComponentDatepickerDatepickerItemYearWidthSize = 77
    public static let ComponentDatepickerDatepickerItemHeightSize = 44
    public static let ComponentDrawersMobileMenuDrawerStackSpace = 20
    public static let ComponentDrawersMobileMenuDrawerLeftInlineSpace = 20
    public static let ComponentDrawersMobileMenuDrawerRightInlineSpace = 16
    public static let ComponentDrawersMobileMenuDrawerMaxWidthSize = 400
    public static let ComponentDropdownDropDownItemStackSpace = 8
    public static let ComponentDropdownDropDownItemInlineSpace = 12
    public static let ComponentDropdownDropDownBorderRadius = 4
    public static let ComponentFooterFooterFontFamily = "Inter"
    /** This variable is used on footer links that commonly show up at the bottom of pages. The font size parameter remains constant at 11 px across device sizes. */
    public static let ComponentFooterFooterFontSize = 11
    public static let ComponentFooterFooterLineHeight = 14
    public static let ComponentFooterFooterFontSizeUserOfferPages = 18
    public static let ComponentFooterFooterLineHeightUserOfferPages = 26
    public static let ComponentIconIconSize = 24
    public static let ComponentIconIconSizeEmbeddMedia = 40
    public static let ComponentInfoElementInfoElementTeaserBadgeMarginSpace = 4
    public static let ComponentInfoElementInfoElementTeaserImageHeightSize = 83
    public static let ComponentInfoElementInfoElementTeaserImageWidthSize = 148
    public static let ComponentInfoElementInfoElementTeaserBadgeHeightSize = 16
    /** This variable controls texts inside of input fields such as dropdowns, date input and other text inputs that appear in forms for example. compact 15 - default 17 - spacious 19 */
    public static let ComponentInputfieldInputFieldFontSize = 16
    public static let ComponentInputfieldInputFieldFontFamily = "Inter"
    public static let ComponentInputfieldInputFieldInlineSpace = 16
    public static let ComponentInputfieldInputFieldStackSpace = 6
    public static let ComponentInputfieldInputFieldMessageGapSpace = 4
    public static let ComponentInputfieldInputFieldIMessageInlineSpace = 16
    public static let ComponentInputfieldInputFieldMiniLabelInlineSpace = 4
    public static let ComponentInputfieldInputFieldHeightSize = 36
    public static let ComponentInputfieldHeyInputContainerInlineSpace = 8
    public static let ComponentLivetickerLiveTickerAppCardHeightSize = 128
    public static let ComponentLivetickerLiveTickerAppCardWidthSize = 300
    public static let ComponentLivetickerTimeStampFontFamily = "Gotham XNarrow"
    public static let ComponentLivetickerLiveTickerheadlineFontWeight = 600
    /** This variable is used for the font size of live ticker headlines. 22 - 22 - 32 - 32 */
    public static let ComponentLivetickerLiveTickerHeadlinesFontSize = 32
    /** This variable is used for the live ticker time stamp font size. 14 - 14 - 16 - 16 */
    public static let ComponentLivetickerLiveTickerTimeStampFontSize = 16
    public static let ComponentLivetickerLiveTickerTime&HeadlineStackSpace = 4
    public static let ComponentLivetickerLiveTickerSliderItemWidthMaxSize = 257
    public static let ComponentMediaplayerAudioPlayerHeaderStackSpace = 56
    public static let ComponentMediaplayerPodcastPlayButtonSize = 48
    public static let ComponentMediaplayerVidPlayerBottomBarGapSpace = 0
    public static let ComponentMediaplayerVideoTimeBadgeFontFamily = "Inter"
    public static let ComponentMediaplayerVidPlayerControlButtonSize = 42
    public static let ComponentMediaplayerVidPlayerControlButtonIconSizeHover = 28
    public static let ComponentMediaplayerVidPlayerTimecodeFontSize = 16
    public static let ComponentMediaplayerVidPlayerTimecodeContainerMinWidthSize = 58
    public static let ComponentMediaplayerVidPlayerProgressBarContainerHeightSize = 24
    public static let ComponentMediaplayerVidPlayerUnmuteButtonWidthSize = 220
    public static let ComponentMenuMenuLinkLaneHeightSize = 48
    public static let ComponentMenuMenuLogoDefaultSize = 56
    public static let ComponentMenuMenuLogoScrolledSize = 56
    public static let ComponentMenuMenuUtillinkItemHeightSize = 48
    public static let ComponentMenuMenuItemUtilFontSize = 12
    /** This variable is used on the menu link lane and on the mobile side menu drawer. */
    public static let ComponentMenuMenuItemFontSize = 18
    public static let ComponentMenuMenuSpecialNaviItemHeightSize = 48
    public static let ComponentMenuMenuItemSpace = 8
    public static let ComponentMenuMenuLinkItemInlineSpace = 4
    public static let ComponentMenuMenuItemUtilStackSpace = 10
    public static let ComponentMenuSubNavBarHeightSize = 42
    public static let ComponentMenuMenuUtilityLinksContainerHeightSize = 56
    public static let ComponentMenuMenuTopStackSpace = 8
    public static let ComponentMenuMenuBottomStackSpace = 8
    public static let ComponentMenuMenuLeftInlineSpace = 8
    public static let ComponentMenuMenuRightInlineSpace = 0
    public static let ComponentMenuMenuUtilityLinksGapSpace = 24
    public static let ComponentMenuMenuUtilityLinksDividerHeightSize = 40
    /** This color type variables are only in this semantic collection for making subtle shadow effects change visibility across device sizes. Shadow alpha: 10 - 10 - 10 - 0 */
    public static let ComponentMenuMenuShadowVisibility = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.100)
    /** This color type variables are only in this semantic collection for making subtle shadow effects change visibility across device sizes. Shadow alpha: 0 - 0 - 0 - 10 */
    public static let ComponentMenuHeyInputShadowVisibility = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.000)
    public static let ComponentMenuIOSappTopBarHeightSize = 48
    public static let ComponentMenuIOSappTopBarLeftInlineSpace = 19
    public static let ComponentMenuIOSappTopBarRightInlineSpace = 19
    public static let ComponentMenuAppTopbarTitleFontSize = 13
    public static let ComponentMenuAppTopbarStageTitleHeight = 17
    public static let ComponentNewstickerNewsTickerAppCardHeightSize = 150
    public static let ComponentNewstickerNewsTickerAppCardWidthSize = 300
    public static let ComponentNewstickerNewsTickerTimeFontFamily = "AntennaExtraCond"
    public static let ComponentNewstickerNewsTickerTimeFontWeight = 700
    /** similar to kicker3 values - 16 - 16 - 16 - 18 */
    public static let ComponentNewstickerNewsTickerTimeFontSize = 16
    /** Figma currently does not allow for percentages in Line Height variables. The values in this token are the result of multiplying the font size by the line height variable defined on the Bild home css -> newsTickerTime line height: 1.3. Line height for this component does not change across devices. */
    public static let ComponentNewstickerNewsTickerTimeLineHeight = 20.8
    public static let ComponentNewstickerNewsTickerBadgesInlineSpace = 12
    public static let ComponentNewstickerNewsTickerEntriesStackSpace = 22
    public static let ComponentNewstickerNewsTickerEntriesLeftInlineSpace = 22
    public static let ComponentNewstickerNewsTickerContentStackSpace = 4
    public static let ComponentNewstickerNewsTickerKickerInnerInlineSpace = 4
    public static let ComponentNewstickerNewsTickerKickerInnerStackSpace = 2
    public static let ComponentNewstickerNewsTickerTime&KickerStackSpace = 6
    public static let ComponentNewstickerNewsTickerTitlesInlineSpace = 24
    public static let ComponentNewstickerNewsTickerSkeletonBottomSpace = 0
    public static let ComponentNewstickerNewsTickerRedDotSize = 14
    public static let ComponentNewstickerNewsTickerLineInlineSpace = 7
    public static let ComponentPaginationGalleryPaginationItemHeightSize = 4
    /** 8 - 8 - 12 - 12 - this component level variable references the inlineSpaceConst semantic variables; SM for smaller devices, MD for larger devices */
    public static let ComponentPaginationGalleryPaginationContainerWebInlineSpace = 12
    public static let ComponentPaginationGalleryPaginationContainerAppInlineSpace = 12
    /** 12 - 12 - 16 - 16 - this component level variable references the semantic */
    public static let ComponentPaginationGalleryPaginationContainerStackSpace = 16
    public static let ComponentPaginationScrollBarThicknessSize = 8
    public static let ComponentPaywallPaywallCardMaxWidthSize = 346
    /** This variable is used on the paywall card price tag. 64 constant */
    public static let ComponentPaywallPaywallCardPriceTagFontSize = 64
    public static let ComponentPaywallPaywallCardPriceTagLineHeight = 64
    /** This variable is used on the paywall card text under the price tag. 40 - 40 - 40 - 40 */
    public static let ComponentPaywallPaywallCardPriceNoteFontSize = 40
    public static let ComponentPaywallPaywallCardPriceNoteLineHeight = 40
    public static let ComponentPaywallPaywallContainerGapSpace = -48
    public static let ComponentPaywallPaywallHeaderBottomStackSpace = 80
    public static let ComponentQuotesQuoteContainerInlineSpace = 16
    public static let ComponentQuotesQuoteContentGapSpace = 48
    public static let ComponentQuotesQuoteContainerStackSpace = 24
    public static let ComponentQuotesQuoteQuotationMarksFontSize = 32
    public static let ComponentRadioButtonsRadioSelectorSize = 20
    public static let ComponentRadioButtonsRadioSelectorDotActiveSize = 12
    public static let ComponentSearchSearchResultBadgeHeightSize = 18
    public static let ComponentSectionTitleSectionTitleInnerStackBottomSpace = 12
    /** This variable is used on large title headings that are h2 elements in html and indicate a new section in the user interface. This space changes when a user hovers over the large title. */
    public static let ComponentSectionTitleSectionTitle&ArrowInlineSpace = 5
    /** This variable is used for increasing the space between the text and the arrow at the end of the large title text. On mobile devices there is no hover state so this variables values are the same as the default state values. */
    public static let ComponentSectionTitleSectionTitle&ArrowInlineSpaceActive = 5
    public static let ComponentSectionTitleSectionTitleHeightSize = 32
    public static let ComponentSeparatorsSeparatorThicknessSize = 2
    public static let ComponentSkeletonsHeadlinesSkeletonImagePlaceholderMaxWidth = 160
    public static let ComponentSkeletonsArticleSkeletonImageInlineSpace = 48
    public static let ComponentSkeletonsArticleSkeletonTextInlineSpace = 48
    public static let ComponentSkeletonsArticleTextSkeletonHeightSize = 720
    public static let ComponentSpecialNaviSpecialNaviInlineSpace = 24
    public static let ComponentSlidersSliderProgressBarIdleHeightSize = 4
    public static let ComponentSlidersSliderProgressBarHoverHeightSize = 8
    public static let ComponentSlidersSliderProgressInactiveHeightSize = 2
    public static let ComponentSlidersVidPlayerProgressBarHeightSize = 12
    public static let ComponentSpinnersVideoSpinnerSize = 80
    public static let ComponentSpinnersVideoSpinnerSize0_5x = 40
    public static let ComponentSpinnersVideoSpinnerStrokeSize = 4
    /** Tab labels font size remain constant at 16px across devices and breakpoints. This behavior can be seen on the Mein Konto page tabs for purchases and payment data. */
    public static let ComponentTabsTabLabelFontSize = 16
    /** Tab labels font size remain constant at 16px across devices and breakpoints. This behavior can be seen on the Mein Konto page tabs for purchases and payment data. */
    public static let ComponentTabsTabLabelFontSizeLine = 16
    public static let ComponentTabsIosTabbarHeightSize = 49
    public static let ComponentTabsAndroidTabbarHeightSize = 74
    /** Tab labels font size remain constant at 16px across devices and breakpoints. This behavior can be seen on the Mein Konto page tabs for purchases and payment data. */
    public static let ComponentTabsAppsTabsLabelFontSize = 16
    /** Tab labels font size remain constant at 16px across devices and breakpoints. This behavior can be seen on the Mein Konto page tabs for purchases and payment data. */
    public static let ComponentTabsAppsTabsLabelLineHeight = 23.4
    public static let ComponentTabsTopBarTabItemHeightSize = 44
    public static let ComponentTableTableColumnWidthSize0_5x = 48
    public static let ComponentTableTableColumnWidthSize0_75x = 64
    public static let ComponentTableTableColumnWidthSize1x = 96
    public static let ComponentTableTableColumnWidthSize1_5x = 160
    public static let ComponentTableTableColumnWidthSize2x = 180
    public static let ComponentTableTableColumnWidthSize2_5x = 240
    public static let ComponentTableTableColumnWidthSize3x = 280
    public static let ComponentTableTableItemMaxWidthSize = 224
    /** 16 - 16 - 22 - 24 This variable references the semantic variables kicker3fontsize and kicker2fontsize. At the 600px breakpoint smaller devices use the kicker3 variable */
    public static let ComponentTeaserATeaserATeaserKickerFontSize = 26
    public static let ComponentTeaserATeaserATeaserKickerLineHeight = 26
    /** This variable references the semantic variables headline3 (XS&SM) and headline2 (MD&LG). 28 - 28 - 48 - 64 */
    public static let ComponentTeaserATeaserATeaserHeadlineFontSize = 44
    public static let ComponentTeaserATeaserATeaserHeadlineLineHeight = 50.6
    public static let ComponentTeaserATeaserATeaserTitleInlineSpace = 16
    public static let ComponentTeaserBTeaserBTeaserTitleInlineSpace = 16
    public static let ComponentTeaserBildPlayBildPlayTeaserWidthSize = 169
    /** XS-headline4FontSize:22 // SM-headline4FontSize:22 // MD-headline3FontSize:36 // LG-headline3FontSize:40 */
    public static let ComponentTeaserMQTeaserMQTeaserHeadlineFontSize = 30
    public static let ComponentTeaserMQTeaserMQTeaserHeadlineLineHeight = 34.5
    public static let ComponentTeaserMQTeaserMQTeaserHeadlineFontWeight = 700
    public static let ComponentTeaserMQTeaserMqTeaserTitleInlineSpace = 12
    /** This token is for controling the height of badges that are inside of teasers. 32 - 32 - 32 - 40 */
    public static let ComponentTeaserTeaserBadgesHeightSizeLG = 32
    public static let ComponentTeaserTeaserBadgesHeightSizeSM = 32
    /** This variable is used for creating space around the outside of a subscription badge or video icon badge. */
    public static let ComponentTeaserTeaserBadgesMarginSpace = 8
    public static let ComponentTeaserTeaserKickerBgInlineSpace = 6
    public static let ComponentTeaserTeaserKickerBgStackSpace = 2
    public static let ComponentTeaserQTeaserQuadKickerFontSize = 26
    /** This component level variable is used on the quad teaser headline. It references the semantic level variable headline1. 48 - 48 - 72 - 100 */
    public static let ComponentTeaserQTeaserQuadHeadlineFontSize = 60
    public static let ComponentTeaserQTeaserQuadHeadlineLineHeight = 69
    public static let ComponentTeaserQTeaserQTeaserTitleInlineSpace = 24
    public static let ComponentTeaserTeaserLayoutGridSpace = 12
    /** This variable is used for creating space around the outside of a subscription badge or video icon badge. */
    public static let ComponentTeaserStdTeaserStdTeaserBadgesMarginSpace = 8
    public static let ComponentTeaserStdTeaserStdTeaserImageTitleGapSpace = 6
    /** 2 | 2 | 2 | 2 - This variable is used on the standard teaser vertical spacing between the kicker and the headline. It references the semantic variable stackSpaceConst3XS */
    public static let ComponentTeaserStdTeaserStdTeaserKickerHeadlineStackSpace = 2
    /** 16 - 16 - 16 - 16 */
    public static let ComponentTeaserSuperASuperATeaserTitleInlineSpace = 24
    public static let ComponentTeaserTeaserTitleInlineLeftSpace = 0
    public static let ComponentTeaserTeaserTitleStackSpace = 4
    public static let ComponentTeaserTeaserTitleGapSpace = 4
    public static let ComponentTeaserTeaserTitleBottomStackSpace = 16
    /** This variable is used on labels in list items with toggle switches found in app preferences. 14 - 14 - 16 - 18 */
    public static let ComponentToggleSwitchAppToggleItemLabelFontSize = 16
    /** This variable is used on labels in list items with toggle switches found in app preferences. 14.1 - 14.1 - 16.2 - 18.2 */
    public static let ComponentToggleSwitchAppToggleItemLabelLineHeight = 16.2
    public static let ComponentVideoVideoBadgeTimeLineHeight = 23.8
    /** 16 - 16 - 18 - 18 -- This variable is used to control the videoTimeBadge text style's font size parameter. The typography style that uses this variable is the videoTimeBadge style. The badge that uses this variable appears on the upper right corner of horizontal videos. */
    public static let ComponentVideoVideoTimeBadgeFontSize = 18
    public static let ComponentVideoVerticalVideoMockHeadlineFontSize = 32
    public static let ComponentVideoVideoFrameInlineSpace = 12
    /** This variable is used for changing the red play icon inside the white square. */
    public static let ComponentVideoVideoRedPlayIconHeightSize = 14
    public static let ComponentVideoVideoRedPlayIconWidthSize = 12
    public static let ComponentVideoVideoSkeletonContainerHeight = 464
    /** 24 - 24 - 32 - 40 - This variable is used on horizontal video badges that contain a red play icon on top of a white square next to a timestamp. */
    public static let ComponentVideoVideoTimeBadgeSize = 32
    /** This variable is used on video player badges that display a red play icon on top of a white square next to a time stamp. This variable references the borderRadiusXS. Constant value of 2 across device sizes. */
    public static let ComponentVideoVideoTimeBadgeCornerSize = 2
    /** 14 - 14 - 16 - 16 -- This variable is used in the videoAdBadge font size parameter. */
    public static let ComponentVideoVideoAdBadgeFontSize = 16
    /** This variable is used only for texts and labels that form part of this design system's documentation. */
    public static let Component_DSysDocsSpecsFontFamily = "Gotham"
    /** This variable is used only for this design system's component tests. */
    public static let Component_DSysDocs1columnMobile = 930
    public static let Component_DSysDocsDSysDocsWidthSize = 962
    /** This variable is used in documentation pages that have small caption or lables along with a UI component documented. 4 - 4 - 6 - 8 */
    public static let Component_DSysDocsDsCaptionStackSpace0_5x = 6
    public static let Component_DSysDocsDsCaptionStackSpace1x = 12
    /** This variable is used on documentation pages. This is an alternative variable to the main container max width variable. 0 - 0 - 68 - 68 */
    public static let Component_DSysDocsDsMainContainerSpace = 68
    /** This variable is used on documentation pages that have an artistic banner at the top of the page that is related to the foundation topic on the page. 80 - 80 -80 - 140 */
    public static let Component_DSysDocsFoundationsBannerHeightSize = 80
    /** This variable is used as a max width size for content blocks. For mobile devices this var references the DSysDocsWidthSize var 320 - 750 - 962 - 1024 */
    public static let Component_DSysDocsMainContentStageSize = 962
    /** This variable is currently used on a thin gallery that appears on desktop websites with petbook and other "books" content. Its height changes to a large height on mobile sites. 558 - 558 - 558 - 186 */
    public static let Component_DSysDocsThinBannerVerticalHeightSize = 558
    /** Variable used in spacing parameters of bild.design webpage mockups. move to bild.design group maybe */
    public static let Component_DSysDocsBildDesignFrameSpace = 64
    /** This variable is used on documentation headers that contain info about platfroms and component names. 144 - 144 - 160 - 180 */
    public static let Component_DSysDocsDocHeaderHeightSize = 160
    public static let BreakpointName = "md"
}
