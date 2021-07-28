package main

import (
	"log"
	tgbotapi "github.com/go-telegram-bot-api/telegram-bot-api"
)


func main() {
	bot, err := tgbotapi.NewBotAPI(">>>>token<<<<")
	if err != nil {
		log.Panic(err)
	}
	bot.Debug = false

	log.Printf("Authorized on account %s", bot.Self.UserName)

	u := tgbotapi.NewUpdate(0)
	u.Timeout = 60

	updates, err := bot.GetUpdatesChan(u)

	for update := range updates {
		if update.Message == nil {
			continue
		}

		log.Printf("[%s] %s", update.Message.From.UserName, update.Message.Text)

		if update.Message.IsCommand() {
			msg := tgbotapi.NewMessage(update.Message.Chat.ID, "")
			switch update.Message.Command() {
			case "start":
				msg.Text = "Hi, i`m slave of nastasyafedotovna/andersen-devops-course repo.\nI can show you available commands by /commands command"
			case "commands":
				msg.Text = "Available commands:\n/start\n/commands\n/git\n/aboutme\n/tilblog\n/tasks\n/task1\n/task2\n/task3\n/task4\n/task5\n/task6"
			case "git":
				msg.Text = "https://github.com/nastasyafedotovna/andersen-devops-course"
			case "tasks":
				msg.Text = "TIL-blog and About me\n1. Ansible task\n2. One-liner to script task\n3. Telegram bot on golang\n4. Git api script task\n5. Docker task\n6. Terraform task"
			case "aboutme":
				msg.Text = "https://github.com/nastasyafedotovna/andersen-devops-course/blob/main/aboutMyself/aboutme.md"
			case "tilblog":
				msg.Text = "https://github.com/nastasyafedotovna/andersen-devops-course/blob/main/TIL/til.md"
			case "task1":
				msg.Text = "https://github.com/nastasyafedotovna/andersen-devops-course/tree/main/ansible_task"
			case "task2":
				msg.Text = "https://github.com/nastasyafedotovna/andersen-devops-course/tree/main/netstat_script"
			case "task3":
				msg.Text = "https://github.com/nastasyafedotovna/andersen-devops-course/tree/main/go_gitbot"
			case "task4":
				msg.Text = "https://github.com/nastasyafedotovna/andersen-devops-course/tree/main/git_api"
			case "task5":
				msg.Text = "https://github.com/nastasyafedotovna/andersen-devops-course/tree/main/docker_task"
			case "task6":
				msg.Text = "https://github.com/nastasyafedotovna/andersen-devops-course/tree/main/terraform_task"
			default:
				msg.Text = "I don't know that command.\nYou can view available commands: /commands"
			}
			bot.Send(msg)
		}

	}
}
