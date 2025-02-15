/*

SDG                                                                           JJ

                                   Scratch

This is the scratch file. It's useful for testing out specific procs and
building some intuition about the package as a whole.

To use it, just uncomment out main, and then run `odin run . -collection...`

You want to use it more like a repl, to try different things and double check
how they work.

Remember the words of Alec Baldwin: A.B.C., Always Be Compiling.

*/

package quic

import "core:fmt"
import "core:net"

decrement_payload :: proc(payload: ^[]u8) {
	payload^ = payload[1:]
}

main :: proc() {
	fmt.println("Your drill is the drill that creates the heavens!")

	callbacks := Callbacks {
		proc(peer: net.Endpoint, conn: ^Conn) {fmt.printfln(
				"new connection from %v: %v",
				peer,
				conn,
			)},
		proc(conn: ^Conn, stream_id: Stream_Id, err: Transport_Error) {
			fmt.printfln(
				"new data available on stream: %v, for conn %v, with err: %v",
				stream_id,
				conn,
				err,
			)
		},
		proc(
			conn: ^Conn,
			//	callback: proc(ctx: rawptr),
			//	callback_ctx: rawptr,
			data: []u8,
		) {fmt.println("new datagram received: %v, on conn: %v", data, conn)},
	}

//	key := hex_decode_const("7db5df06e7a69e432496adedb0085192" +
//							"3595221596ae2ae9fb8115c1e9ed0a44")
//	fmt.printfln("initial_secret: %x", key)
	//	fmt.printfln("client_initial_secret: %x", tlsv13_expand_label(key, "client in", .SHA256, 32))

	//payload := []u8{ 1, 2, 3, 4}
	//decrement_payload(&payload)

	init(.Server, callbacks)
}
