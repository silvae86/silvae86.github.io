---
layout: post
title:  "iTerm2 (Python API): Automatically starting multiple services in separate panes"
date: 2022-11-19 14:04:000 +0100
tags: iterm2 panes python api development macos microservices terminal
published: true
comments_id: 52
---

There are awesome process monitors like [PM2](https://pm2.keymetrics.io/) to help manage multiple services, but
sometimes you need to boot up multiple
fully-dockerized workflows and place them in separate panes for easy log monitoring. iTerm2 has a great Python API to
help automatize these repetitive tasks.

Unfortunately, most examples I found on the web using the iTerm2 Python
API started everything in parallel. I needed to actually wait for each server to print its "ready/listening" message
before moving on to the next one. This rules out port clash problems, synchronisation conflicts, etc. Also, when running
on a laptop, sometimes there is not enough CPU power to boot up everything simultaneously.

Here is my example script for starting multiple services in iTerm2, each on their
separate pane. Each one will wait for a completion message before opening the next pane. I separated the logic into a neat `open_pane_and_start_service` function that you can call multiple times for starting up all the services you need.

## Where to put the script

To use it, save it with a `.py` extension in the iTerm2 scripts folder.

{% include image.html src="/assets/images/post-images/2022-11-20-start-all-services-in-iterm2/reveal-scripts-folder.png"
caption="Opening the iTerm2 Python Scripts folder" imageposition="center"
%}

The script will then appear in the list of available scripts:

{% include image.html src="/assets/images/post-images/2022-11-20-start-all-services-in-iterm2/run-script-option.png"
caption="Script visible in the list of iTerm scripts" imageposition="center"
%}

## What it does, in detail

The script will:

1. Open a new pane at a folder that you specify
    1. Play with `Vertical=True` or  `Vertical=False` to achieve the layout you need
    2. Provide an optional `pane_to_split` value to specify a previous pane to split from
2. Run a command
3. Wait for a certain line to appear on the screen (typically `Listening at...` or similar)
4. Move on to the next service.

Personally, I use this with multiple [mutagen](https://mutagen.io/documentation/introduction/installation) sessions,
which sometimes can take 10+ minutes to perform a full file synchronization first thing in the morning.

## The code

```python
#!/usr/bin/env python3.7
import asyncio
import re
import iterm2


async def open_pane_and_start_service(
        window,
        fs_path,
        command,
        string_to_detect_to_finish,
        pane_to_split=None,
        vertical=False,
):
    tab = window.current_tab
    session = tab.current_session
    pane = session

    if pane_to_split is not None:
        pane = await session.async_split_pane(vertical)
        await pane.async_activate()

    async def run_fs():
        await pane.async_send_text('cd ' + fs_path + '\n')
        await pane.async_send_text(command + '\n')

        finished = False
        async with pane.get_screen_streamer() as streamer:
            while not finished:
                stringified_string_contents = ""
                screen_output = await streamer.async_get()
                for line_no in range(screen_output.number_of_lines + screen_output.number_of_lines_above_screen):
                    stringified_string_contents = stringified_string_contents + screen_output.line(line_no).string
                if len(stringified_string_contents) > 0:
                    finished = re.search(pattern=string_to_detect_to_finish,
                                         string=stringified_string_contents,
                                         flags=re.IGNORECASE) is not None
            print("Found string [ " + string_to_detect_to_finish + " ] , service is started.")
        return pane

    loop = asyncio.get_event_loop()
    f_task = loop.create_task(run_fs())

    await f_task
    return pane


async def main(connection):
    app = await iterm2.async_get_app(connection)
    window = app.current_terminal_window

    if window is not None:
        # Service 1
        service_1 = await open_pane_and_start_service(
            window,
            "~/GitHub/service_1",
            "make start-dev",
            "Watching for changes...",
            vertical=False,
        )

        # Service 2
        service_2 = await open_pane_and_start_service(
            window,
            "~/GitHub/service_2",
            "make start-dev",
            "compiled successfully in",
            pane_to_split=service_1,
            vertical=True
        )

        # Service 3
        service_2 = await open_pane_and_start_service(
            window,
            "~/GitHub/service_3",
            "make build && make start",
            "Listening on",
            vertical=False,
            pane_to_split = service_2
        )

        # Service 4
        service_4 = await open_pane_and_start_service(
            window,
            "~/GitHub/service_4",
            "make start",
            "Server started at",
            vertical=True,
            pane_to_split = service_3
        )
    else:
        print("No current window")


iterm2.run_until_complete(main)
```

Now you can start all your microservices while you brew your morning coffee!


