float4 g_MatrialColor : register(c184);
float4x4 g_WorldViewProjMatrix : register(c24);

struct VS_OUT
{
	float4 position : POSITION;
	float4 color : COLOR;
};

VS_OUT main(float4 position : POSITION)
{
	VS_OUT o;

	o.position.x = dot(position, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(position, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(position, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(position, transpose(g_WorldViewProjMatrix)[3]);
	o.color = g_MatrialColor;

	return o;
}
