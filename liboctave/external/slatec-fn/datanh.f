*DECK DATANH
      DOUBLE PRECISION FUNCTION DATANH (X)
C***BEGIN PROLOGUE  DATANH
C***PURPOSE  Compute the arc hyperbolic tangent.
C***LIBRARY   SLATEC (FNLIB)
C***CATEGORY  C4C
C***TYPE      DOUBLE PRECISION (ATANH-S, DATANH-D, CATANH-C)
C***KEYWORDS  ARC HYPERBOLIC TANGENT, ATANH, ELEMENTARY FUNCTIONS,
C             FNLIB, INVERSE HYPERBOLIC TANGENT
C***AUTHOR  Fullerton, W., (LANL)
C***DESCRIPTION
C
C DATANH(X) calculates the double precision arc hyperbolic
C tangent for double precision argument X.
C
C Series for ATNH       on the interval  0.          to  2.50000E-01
C                                        with weighted error   6.86E-32
C                                         log weighted error  31.16
C                               significant figures required  30.00
C                                    decimal places required  31.88
C
C***REFERENCES  (NONE)
C***ROUTINES CALLED  D1MACH, DCSEVL, INITDS, XERMSG
C***REVISION HISTORY  (YYMMDD)
C   770601  DATE WRITTEN
C   890531  Changed all specific intrinsics to generic.  (WRB)
C   890531  REVISION DATE from Version 3.2
C   891214  Prologue converted to Version 4.0 format.  (BAB)
C   900315  CALLs to XERROR changed to CALLs to XERMSG.  (THJ)
C***END PROLOGUE  DATANH
      DOUBLE PRECISION X, ATNHCS(27), DXREL, SQEPS, Y, DCSEVL, D1MACH
      LOGICAL FIRST
      SAVE ATNHCS, NTERMS, DXREL, SQEPS, FIRST
      DATA ATNHCS(  1) / +.9439510239 3195492308 4289221863 3 D-1      /
      DATA ATNHCS(  2) / +.4919843705 5786159472 0003457666 8 D-1      /
      DATA ATNHCS(  3) / +.2102593522 4554327634 7932733175 2 D-2      /
      DATA ATNHCS(  4) / +.1073554449 7761165846 4073104527 6 D-3      /
      DATA ATNHCS(  5) / +.5978267249 2930314786 4278751787 2 D-5      /
      DATA ATNHCS(  6) / +.3505062030 8891348459 6683488620 0 D-6      /
      DATA ATNHCS(  7) / +.2126374343 7653403508 9621931443 1 D-7      /
      DATA ATNHCS(  8) / +.1321694535 7155271921 2980172305 5 D-8      /
      DATA ATNHCS(  9) / +.8365875501 1780703646 2360405295 9 D-10     /
      DATA ATNHCS( 10) / +.5370503749 3110021638 8143458777 2 D-11     /
      DATA ATNHCS( 11) / +.3486659470 1571079229 7124578429 0 D-12     /
      DATA ATNHCS( 12) / +.2284549509 6034330155 2402411972 2 D-13     /
      DATA ATNHCS( 13) / +.1508407105 9447930448 7422906755 8 D-14     /
      DATA ATNHCS( 14) / +.1002418816 8041091261 3699572283 7 D-15     /
      DATA ATNHCS( 15) / +.6698674738 1650695397 1552688298 6 D-17     /
      DATA ATNHCS( 16) / +.4497954546 4949310830 8332762453 3 D-18     /
      DATA ATNHCS( 17) / +.3032954474 2794535416 8236714666 6 D-19     /
      DATA ATNHCS( 18) / +.2052702064 1909368264 6386141866 6 D-20     /
      DATA ATNHCS( 19) / +.1393848977 0538377131 9301461333 3 D-21     /
      DATA ATNHCS( 20) / +.9492580637 2245769719 5895466666 6 D-23     /
      DATA ATNHCS( 21) / +.6481915448 2423076049 8244266666 6 D-24     /
      DATA ATNHCS( 22) / +.4436730205 7236152726 3232000000 0 D-25     /
      DATA ATNHCS( 23) / +.3043465618 5431616389 1200000000 0 D-26     /
      DATA ATNHCS( 24) / +.2091881298 7923934740 4799999999 9 D-27     /
      DATA ATNHCS( 25) / +.1440445411 2340505613 6533333333 3 D-28     /
      DATA ATNHCS( 26) / +.9935374683 1416404650 6666666666 6 D-30     /
      DATA ATNHCS( 27) / +.6863462444 3582600533 3333333333 3 D-31     /
      DATA FIRST /.TRUE./
C***FIRST EXECUTABLE STATEMENT  DATANH
      IF (FIRST) THEN
         NTERMS = INITDS (ATNHCS, 27, 0.1*REAL(D1MACH(3)) )
         DXREL = SQRT(D1MACH(4))
         SQEPS = SQRT(3.0D0*D1MACH(3))
      ENDIF
      FIRST = .FALSE.
C
      Y = ABS(X)
      IF (Y .GE. 1.D0) THEN
         IF (Y .GT. 1.D0) THEN
            DATANH = (X - X) / (X - X)
         ELSE
            DATANH = X / 0.D0
         ENDIF
         RETURN
      ENDIF
C
      IF (1.D0-Y .LT. DXREL) CALL XERMSG ('SLATEC', 'DATANH',
     +   'ANSWER LT HALF PRECISION BECAUSE ABS(X) TOO NEAR 1', 1, 1)
C
      DATANH = X
      IF (Y.GT.SQEPS .AND. Y.LE.0.5D0) DATANH = X*(1.0D0 +
     1  DCSEVL (8.D0*X*X-1.D0, ATNHCS, NTERMS) )
      IF (Y.GT.0.5D0) DATANH = 0.5D0*LOG ((1.0D0+X)/(1.0D0-X))
C
      RETURN
      END
