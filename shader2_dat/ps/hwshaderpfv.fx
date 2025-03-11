float4 g_MatrialColor : register(c62);
float4 g_OutLineColor : register(c63);

float4 main(float3 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float3 r2;
	r0.y = r0.w * r0.y;
	r0.x = r0.x * r0.z + -r0.y;
	r0.x = (-r0.x >= 0) ? -1 : 0;
	r0.yzw = texcoord.yzx + texcoord.xyz;
	r1.x = max(r0.y, r0.z);
	r2.x = max(r1.x, r0.w);
	r0.y = -r2.x + g_OutLineColor.w;
	r1 = (r0.y >= 0) ? r0.x : 0;
	r2.xyz = g_OutLineColor.xyz;
	o.xyz = (r0.yyy >= 0) ? g_MatrialColor.xyz : r2.xyz;
	clip(r1);
	o.w = 1;

	return o;
}
