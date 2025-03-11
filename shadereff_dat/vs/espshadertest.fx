float4x4 g_WorldViewProjMatrix : register(c24);

float4 main(float4 position : POSITION) : POSITION
{
	float4 o;

	o.x = dot(position, transpose(g_WorldViewProjMatrix)[0]);
	o.y = dot(position, transpose(g_WorldViewProjMatrix)[1]);
	o.z = dot(position, transpose(g_WorldViewProjMatrix)[2]);
	o.w = dot(position, transpose(g_WorldViewProjMatrix)[3]);

	return o;
}
