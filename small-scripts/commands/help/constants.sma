new helpFile[] = "small-scripts/commands/help/helpTopics.txt";

#define NUM_HELP_TOPICS 50
enum helpTopicStruct
{
	__helpTopic: 20,
	__helpText: 512
}
new helpTopics[NUM_HELP_TOPICS][helpTopicStruct];