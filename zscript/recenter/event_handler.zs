/* Copyright Alexander Kromm (mmaulwurff@gmail.com) 2020-2021
 *
 * This file is part of Recenter.
 *
 * Recenter is free software: you can redistribute it and/or modify it under the
 * terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 *
 * Recenter is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
 * A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * Recenter.  If not, see <https://www.gnu.org/licenses/>.
 */

class rc_EventHandler : EventHandler
{

  override
  void worldTick()
  {
    PlayerPawn player = players[consolePlayer].mo;
    if (player == NULL) return;

    if (!mIsInitialized) initialize();
    if (!mIsEnabled.getBool()) return;

    player.a_SetPitch(makeNewPitch(player.pitch, mStep.getDouble()), SPF_Interpolate);
  }

// private: ////////////////////////////////////////////////////////////////////////////////////////

  private
  void initialize()
  {
    mIsInitialized = true;
    mIsEnabled = rc_Cvar.from("rc_enabled");
    mStep      = rc_Cvar.from("rc_step");
  }

  private static
  double makeNewPitch(double pitch, double step)
  {
    if (abs(pitch) <= step) return 0;
    else if (pitch > 0)     return pitch - step;
    else                    return pitch + step;
  }

  const STEP = 1;

  private rc_Cvar mIsEnabled;
  private rc_Cvar mStep;
  private bool    mIsInitialized;

} // class rc_EventHandler
