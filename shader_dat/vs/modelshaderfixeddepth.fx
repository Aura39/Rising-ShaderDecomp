float4x4 g_WorldViewProj;

float4 main(float4 position : POSITION) : POSITION
{
	float4 o;

	float4 r0;
	r0 = position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	o.x = dot(r0, transpose(g_WorldViewProj)[0]);
	o.y = dot(r0, transpose(g_WorldViewProj)[1]);
	o.z = dot(r0, transpose(g_WorldViewProj)[2]);
	o.w = dot(r0, transpose(g_WorldViewProj)[3]);

	return o;
}
