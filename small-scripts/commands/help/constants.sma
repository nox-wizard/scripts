new helpFile[] = "small-scripts/translations/helpTopics.txt";

#define NUM_HELP_TOPICS 100
new NUM_LOADED_TOPICS = 0;
enum helpTopicStruct
{
	__helpTopic: 20,
	__helpText: 512
}
new helpTopics[NUM_HELP_TOPICS][helpTopicStruct];