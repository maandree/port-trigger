/**
 * port-trigger – Run programs when someone makes a connection to a specific port
 * 
 * Copyright © 2013, 2014  Mattias Andrée (maandree@member.fsf.org)
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
import java.net.*;


public class PortTrigger
{
    public static void main(final String... args) throws Exception
    {
	if (args.length == 0)
	{
	    System.out.println("USAGE: @COMMAND@ PORT COMMAND_ARGUMENTS...");
	    return;
	}
	
	final int port = Integer.parseInt(args[0]);
	final String[] command = new String[args.length - 1];
	System.arraycopy(args, 1, command, 0, command.length);
	
	ServerSocket sock = new ServerSocket(port);
	for (;;)
	{
	    sock.accept().close();
	    try
	    {   (new ProcessBuilder(command)).start();
	    }
	    catch (final Exception ignore)
	    {   /* ignore */
	    }
	}
    }
    
}

