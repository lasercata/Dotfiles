#!/usr/bin/env python

# https://github.com/Psykar/i3-backandforth-externalmonitor

# Note : this script is not used in the current config (lasercata's dotfiles), but is kept here as there are interesting principles.

import logging
import i3ipc

logging.basicConfig(level=logging.INFO)

class Swapper:
    def __init__(self):
        i3 = i3ipc.Connection()
        self.previous_2_workspaces = None
        self.previous_workspaces = None
        self.previous_command = None

        i3.on('binding', self.binding_event)
        i3.main()

    def binding_event(self, connection, data):
        print(data.binding.command)

        # if not data.binding.command.startswith('workspace number '):
        if not data.binding.command.startswith('workspace '):
            return

        workspaces = connection.get_workspaces()

        if self.previous_command == data.binding.command:
            logging.debug("Checking...")
            try:
                make_visible, new_workspace = self.swap_back(workspaces)
            except TypeError as err:
                print(err)
            else:
                logging.debug("Restoring...")
                if make_visible and new_workspace:
                    for workspace in make_visible:
                        command = f'workspace number "{workspace}'
                        logging.debug(f'Running {command}')
                        connection.command(command)
                    # Now actually swap to where we were supposed to go
                    command = f'workspace number "{new_workspace["num"]}"'
                    logging.debug(f"Running {command}")
                    connection.command(command)

                    # And update workspaces as we want to save the
                    # resulting output, not the one we calculated from
                    workspaces = connection.get_workspaces()


        self.previous_2_workspaces = self.previous_workspaces
        self.previous_workspaces = workspaces
        self.previous_command = data.binding.command

    def swap_back(self, workspaces):
        previous_workspace = {}
        if self.previous_workspaces:
            for workspace in self.previous_workspaces:
                if workspace['focused']:
                    previous_workspace = workspace

        previous_visible = {}
        if self.previous_2_workspaces:
            for workspace in self.previous_2_workspaces:
                if workspace['visible']:
                    previous_visible[workspace['output']] = workspace['num']

        new_workspace = {}
        new_visible = {}
        for workspace in workspaces:
            if workspace['focused']:
                new_workspace = workspace
            if workspace['visible']:
                new_visible[workspace['output']] = workspace['num']

        if previous_workspace.get('output') == new_workspace.get('output'):
            # Didn't swap monitors, don't do anything
            logging.debug("Didn't swap monitors, don't do anything")
            return



        if self.previous_2_workspaces == workspaces:
            # Didn't swap workspaces on the second screen, don't do anything
            logging.debug("Didn't swap workspaces on second screen, don't do anything")
            return

        # OK now we need to swap the old monitor back
        logging.debug("DId something, calculate return value")
        return (set(previous_visible.values()) - set(new_visible.values())), new_workspace

Swapper()
