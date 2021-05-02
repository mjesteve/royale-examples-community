import CalendarMonth from './CalendarMonth';
export default interface CalendarPeriod {
    /**
     * The beginning of the period.
     */
    start: CalendarMonth;
    /**
     * The end of the period.
     */
    end: CalendarMonth;
}
