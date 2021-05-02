import CalendarContextMenuItem from './interfaces/CalendarContextMenuItem';
import CalendarDataSourceElement from './interfaces/CalendarDataSourceElement';
import CalendarOptions from './interfaces/CalendarOptions';
import CalendarYearChangedEventObject from './interfaces/CalendarYearChangedEventObject';
import CalendarPeriodChangedEventObject from './interfaces/CalendarPeriodChangedEventObject';
import CalendarDayEventObject from './interfaces/CalendarDayEventObject';
import CalendarRenderEndEventObject from './interfaces/CalendarRenderEndEventObject';
import CalendarRangeEventObject from './interfaces/CalendarRangeEventObject';
/**
 * Calendar instance.
 */
export default class Calendar<T extends CalendarDataSourceElement> {
    protected element: HTMLElement;
    protected options: CalendarOptions<T>;
    protected _startDate: Date;
    protected _dataSource: T[];
    protected _mouseDown: boolean;
    protected _rangeStart: Date;
    protected _rangeEnd: Date;
    protected _responsiveInterval: any;
    protected _nbCols: number;
    protected static locales: {
        en: {
            days: string[];
            daysShort: string[];
            daysMin: string[];
            months: string[];
            monthsShort: string[];
            weekShort: string;
            weekStart: number;
        };
    };
    protected static colors: string[];
    /**
     * Fired when a day is clicked.
     * @event
     * @example
     * ```
     *
     * document.querySelector('.calendar').addEventListener('clickDay', function(e) {
     *   console.log("Click on day: " + e.date + " (" + e.events.length + " events)");
     * })
     * ```
     */
    clickDay: CalendarDayEventObject<T>;
    /**
     * Fired when a day is right clicked.
     * @event
     * @example
     * ```
     *
     * document.querySelector('.calendar').addEventListener('clickDay', function(e) {
     *   console.log("Right click on day: " + e.date + " (" + e.events.length + " events)");
     * })
     * ```
     */
    dayContextMenu: CalendarDayEventObject<T>;
    /**
     * Fired when the mouse enter in a day.
     * @event
     * @example
     * ```
     *
     * document.querySelector('.calendar').addEventListener('mouseOnDay', function(e) {
     *   console.log("Mouse enter in a day: " + e.date + " (" + e.events.length + " events)");
     * })
     * ```
     */
    mouseOnDay: CalendarDayEventObject<T>;
    /**
     * Fired when the mouse leave a day.
     * @event
     * @example
     * ```
     *
     * document.querySelector('.calendar').addEventListener('mouseOutDay', function(e) {
     *   console.log("Mouse leave a day: " + e.date + " (" + e.events.length + " events)");
     * })
     * ```
     */
    mouseOutDay: CalendarDayEventObject<T>;
    /**
     * Fired when the calendar rendering is ended.
     * @event
     * @example
     * ```
     *
     * document.querySelector('.calendar').addEventListener('renderEnd', function(e) {
     *   console.log("Render end for year: " + e.currentYear);
     * })
     * ```
     */
    renderEnd: CalendarRenderEndEventObject;
    /**
     * Fired when a date range is selected.
     *
     * Don't forget to enable the `enableRangeSelection` option to be able to use the range selection functionality.
     * @event
     * @example
     * ```
     *
     * document.querySelector('.calendar').addEventListener('selectRange', function(e) {
     *   console.log("Select the range: " + e.startDate + " - " + e.endDate);
     * })
     * ```
     */
    selectRange: CalendarRangeEventObject;
    /**
     * Triggered after the changing the current year.
     * Works only if the calendar is used in a full year mode. Otherwise, use `periodChanged` event.
     * @event
     * @example
     * ```
     *
     * document.querySelector('.calendar').addEventListener('yearChanged', function(e) {
     *   console.log("New year selected: " + e.currentYear);
     * })
     * ```
     */
    yearChanged: CalendarYearChangedEventObject;
    /**
     * Triggered after the changing the visible period.
     * @event
     * @example
     * ```
     *
     * document.querySelector('.calendar').addEventListener('periodChanged', function(e) {
     *   console.log(`New period selected: ${e.startDate} ${e.endDate}`);
     * })
     * ```
     */
    periodChanged: CalendarPeriodChangedEventObject;
    /**
     * Create a new calendar.
     * @param element The element (or the selector to an element) in which the calendar should be created.
     * @param options [Optional] The options used to customize the calendar
     */
    constructor(element: HTMLElement | string, options?: CalendarOptions<T>);
    protected _initializeOptions(opt: any): void;
    protected _initializeEvents(opt: any): void;
    protected _fetchDataSource(callback: (dataSource: T[]) => void): void;
    protected _initializeDatasourceColors(): void;
    /**
     * Renders the calendar.
     */
    render(isLoading?: boolean): void;
    protected _renderHeader(): void;
    protected _renderBody(): void;
    protected _renderLoading(): void;
    protected _renderDataSource(): void;
    protected _renderDataSourceDay(elt: HTMLElement, currentDate: Date, events: T[]): void;
    protected _applyEvents(): void;
    protected _refreshRange(): void;
    protected _getElementPosition(element: HTMLElement): {
        top: number;
        left: number;
    };
    protected _openContextMenu(elt: HTMLElement): void;
    protected _renderContextMenuItems(parent: HTMLElement, items: CalendarContextMenuItem<T>[], evt: T): void;
    protected _checkContextMenuItemsPosition(): void;
    protected _getDate(elt: any): Date;
    protected _triggerEvent(eventName: string, parameters: any): any;
    protected _isDisabled(date: Date): boolean;
    protected _isHidden(day: number): boolean;
    protected _isFullYearMode(): boolean;
    /**
     * Gets the week number for a specified date.
     *
     * @param date The specified date.
     */
    getWeekNumber(date: Date): number;
    /**
     * Gets the data source elements for a specified day.
     *
     * @param date The specified day.
     */
    getEvents(date: Date): T[];
    /**
     * Gets the data source elements for a specified range of days.
     *
     * @param startDate The beginning of the day range (inclusive).
     * @param endDate The end of the day range (non inclusive).
     */
    getEventsOnRange(startDate: Date, endDate: Date): T[];
    /**
     * Check if there is no event on the first part, last part or on the whole specified day.
     *
     * @param date The specified day.
     * @param after Whether to check for a free slot on the first part (if `false`) or the last part (if `true`) of the day. If `null`, this will check on the whole day.
     *
     * Usefull only if using the `alwaysHalfDay` option of the calendar, or the `startHalfDay` or `endHalfDay` option of the datasource.
     */
    isThereFreeSlot(date: Date, after?: Boolean): Boolean;
    /**
     * Gets the period displayed on the calendar.
     */
    getCurrentPeriod(): {
        startDate: Date;
        endDate: Date;
    };
    /**
     * Gets the year displayed on the calendar.
     * If the calendar is not used in a full year configuration, this will return the year of the first date displayed in the calendar.
     */
    getYear(): number | null;
    /**
     * Sets the year displayed on the calendar.
     * If the calendar is not used in a full year configuration, this will set the start date to January 1st of the given year.
     *
     * @param year The year to displayed on the calendar.
     */
    setYear(year: number | string): void;
    /**
     * Gets the first date displayed on the calendar.
     */
    getStartDate(): Date;
    /**
     * Sets the first date that should be displayed on the calendar.
     *
     * @param startDate The first date that should be displayed on the calendar.
     */
    setStartDate(startDate: Date): void;
    /**
     * Gets the number of months displayed by the calendar.
     */
    getNumberMonthsDisplayed(): number;
    /**
     * Sets the number of months displayed that should be displayed by the calendar.
     *
     * This method causes a refresh of the calendar.
     *
     * @param numberMonthsDisplayed Number of months that should be displayed by the calendar.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setNumberMonthsDisplayed(numberMonthsDisplayed: number | string, preventRendering?: boolean): void;
    /**
     * Gets the minimum date of the calendar.
     */
    getMinDate(): Date;
    /**
     * Sets the minimum date of the calendar.
     *
     * This method causes a refresh of the calendar.
     *
     * @param minDate The minimum date to set.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setMinDate(date: Date, preventRendering?: boolean): void;
    /**
     * Gets the maximum date of the calendar.
     */
    getMaxDate(): Date;
    /**
     * Sets the maximum date of the calendar.
     *
     * This method causes a refresh of the calendar.
     *
     * @param maxDate The maximum date to set.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setMaxDate(date: Date, preventRendering?: boolean): void;
    /**
     * Gets the current style used for displaying data source.
     */
    getStyle(): string;
    /**
     * Sets the style to use for displaying data source.
     *
     * This method causes a refresh of the calendar.
     *
     * @param style The style to use for displaying data source ("background", "border" or "custom").
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setStyle(style: string, preventRendering?: boolean): void;
    /**
     * Gets a value indicating whether the user can select a range which overlapping an other element present in the datasource.
     */
    getAllowOverlap(): boolean;
    /**
     * Sets a value indicating whether the user can select a range which overlapping an other element present in the datasource.
     *
     * @param allowOverlap Indicates whether the user can select a range which overlapping an other element present in the datasource.
     */
    setAllowOverlap(allowOverlap: boolean): void;
    /**
     * Gets a value indicating whether the weeks number are displayed.
     */
    getDisplayWeekNumber(): boolean;
    /**
     * Sets a value indicating whether the weeks number are displayed.
     *
     * This method causes a refresh of the calendar.
     *
     * @param  displayWeekNumber Indicates whether the weeks number are displayed.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setDisplayWeekNumber(displayWeekNumber: boolean, preventRendering?: boolean): void;
    /**
     * Gets a value indicating whether the calendar header is displayed.
     */
    getDisplayHeader(): boolean;
    /**
     * Sets a value indicating whether the calendar header is displayed.
     *
     * This method causes a refresh of the calendar.
     *
     * @param displayHeader Indicates whether the calendar header is displayed.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setDisplayHeader(displayHeader: boolean, preventRendering?: boolean): void;
    /**
     * Gets a value indicating whether the data source must be rendered on disabled days.
     */
    getDisplayDisabledDataSource(): boolean;
    /**
     * Sets a value indicating whether the data source must be rendered on disabled days.
     *
     * This method causes a refresh of the calendar.
     *
     * @param displayDisabledDataSource Indicates whether the data source must be rendered on disabled days.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setDisplayDisabledDataSource(displayDisabledDataSource: boolean, preventRendering?: boolean): void;
    /**
     * Gets a value indicating whether the beginning and the end of each range should be displayed as half selected day.
     */
    getAlwaysHalfDay(): boolean;
    /**
     * Sets a value indicating whether the beginning and the end of each range should be displayed as half selected day.
     *
     * This method causes a refresh of the calendar.
     *
     * @param alwaysHalfDay Indicates whether the beginning and the end of each range should be displayed as half selected day.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setAlwaysHalfDay(alwaysHalfDay: boolean, preventRendering?: boolean): void;
    /**
     * Gets a value indicating whether the user can make range selection.
     */
    getEnableRangeSelection(): boolean;
    /**
     * Sets a value indicating whether the user can make range selection.
     *
     * This method causes a refresh of the calendar.
     *
     * @param enableRangeSelection Indicates whether the user can make range selection.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setEnableRangeSelection(enableRangeSelection: boolean, preventRendering?: boolean): void;
    /**
     * Gets the disabled days.
     */
    getDisabledDays(): Date[];
    /**
     * Sets the disabled days.
     *
     * This method causes a refresh of the calendar.
     *
     * @param disableDays The disabled days to set.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setDisabledDays(disabledDays: Date[], preventRendering?: boolean): void;
    /**
     * Gets the disabled days of the week.
     */
    getDisabledWeekDays(): number[];
    /**
     * Sets the disabled days of the week.
     *
     * This method causes a refresh of the calendar.
     *
     * @param disabledWeekDays The disabled days of the week to set.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setDisabledWeekDays(disabledWeekDays: number[], preventRendering?: boolean): void;
    /**
     * Gets the hidden days of the week.
     */
    getHiddenWeekDays(): number[];
    /**
     * Sets the hidden days of the week.
     *
     * This method causes a refresh of the calendar.
     *
     * @param hiddenWeekDays The hidden days of the week to set.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setHiddenWeekDays(hiddenWeekDays: number[], preventRendering?: boolean): void;
    /**
     * Gets a value indicating whether the beginning and the end of each range should be displayed as rounded cells.
     */
    getRoundRangeLimits(): boolean;
    /**
     * Sets a value indicating whether the beginning and the end of each range should be displayed as rounded cells.
     *
     * This method causes a refresh of the calendar.
     *
     * @param roundRangeLimits Indicates whether the beginning and the end of each range should be displayed as rounded cells.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setRoundRangeLimits(roundRangeLimits: boolean, preventRendering?: boolean): void;
    /**
     * Gets a value indicating whether the default context menu must be displayed when right clicking on a day.
     */
    getEnableContextMenu(): boolean;
    /**
     * Sets a value indicating whether the default context menu must be displayed when right clicking on a day.
     *
     * This method causes a refresh of the calendar.
     *
     * @param enableContextMenu Indicates whether the default context menu must be displayed when right clicking on a day.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setEnableContextMenu(enableContextMenu: boolean, preventRendering?: boolean): void;
    /**
     * Gets the context menu items.
     */
    getContextMenuItems(): CalendarContextMenuItem<T>[];
    /**
     * Sets new context menu items.
     *
     * This method causes a refresh of the calendar.
     *
     * @param contextMenuItems The new context menu items.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setContextMenuItems(contextMenuItems: CalendarContextMenuItem<T>[], preventRendering?: boolean): void;
    /**
     * Gets the custom day renderer.
     */
    getCustomDayRenderer(): (element: HTMLElement, currentDate: Date) => void;
    /**
     * Sets the custom day renderer.
     *
     * This method causes a refresh of the calendar.
     *
     * @param handler The function used to render the days. This function is called during render for each day.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setCustomDayRenderer(customDayRenderer: (element: HTMLElement, currentDate: Date) => void, preventRendering?: boolean): void;
    /**
     * Gets the custom data source renderer.
     */
    getCustomDataSourceRenderer(): (element: HTMLElement, currentDate: Date, events: T[]) => void;
    /**
     * Sets the custom data source renderer. Works only with the style set to "custom".
     *
     * This method causes a refresh of the calendar.
     *
     * @param handler The function used to render the data source. This function is called during render for each day containing at least one event.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setCustomDataSourceRenderer(customDataSourceRenderer: (element: HTMLElement, currentDate: Date, events: T[]) => void, preventRendering?: boolean): void;
    /**
     * Gets the language used for calendar rendering.
     */
    getLanguage(): string;
    /**
     * Sets the language used for calendar rendering.
     *
     * This method causes a refresh of the calendar.
     *
     * @param language The language to use for calendar redering.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setLanguage(language: string, preventRendering?: boolean): void;
    /**
     * Gets the current data source.
     */
    getDataSource(): T[] | ((currentYear: number) => T[] | Promise<T[]>) | ((currentYear: number, done: (result: T[]) => void) => void);
    /**
     * Sets a new data source.
     *
     * This method causes a refresh of the calendar.
     *
     * @param dataSource The new data source.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setDataSource(dataSource: T[] | ((currentYear: number) => T[] | Promise<T[]>) | ((currentYear: number, done: (result: T[]) => void) => void), preventRendering?: boolean): void;
    /**
     * Gets the starting day of the week.
     */
    getWeekStart(): number;
    /**
     * Sets the starting day of the week.
     *
     * This method causes a refresh of the calendar.
     *
     * @param weekStart The starting day of the week. This option overrides the parameter define in the language file.
     * @param preventRedering Indicates whether the rendering should be prevented after the property update.
     */
    setWeekStart(weekStart: number | string, preventRendering?: boolean): void;
    /**
     * Gets the loading template.
     */
    getLoadingTemplate(): string | HTMLElement;
    /**
     * Sets the loading template.
     *
     * @param loadingTemplate The loading template.
     */
    setLoadingTemplate(loadingTemplate: string | HTMLElement): void;
    /**
     *
     * Add a new element to the data source.
     *
     * This method causes a refresh of the calendar.
     *
     * @param element The element to add.
     * @param preventRendering Indicates whether the calendar shouldn't be refreshed once the event added.
     */
    addEvent(evt: T, preventRendering?: boolean): void;
}
declare global {
    interface Window {
        Calendar: any;
    }
}
