float4 g_MatrialColor;
sampler g_Sampler0;
sampler g_Sampler1;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = float4(0.00390625, 0, 0, 0.00390625) + texcoord.xyxy;
	r1 = tex2D(g_Sampler0, r0.zwzw);
	r0 = tex2D(g_Sampler0, r0);
	r0.y = r1.x + r0.x;
	r1 = float4(-0.00390625, 0, 0, -0.00390625) + texcoord.xyxy;
	r2 = tex2D(g_Sampler0, r1);
	r1 = tex2D(g_Sampler0, r1.zwzw);
	r0.y = r0.y + r2.x;
	r0.y = r1.x + r0.y;
	r0.x = r0.x * -4 + r0.y;
	r0.yz = 0.001953125 + texcoord.xy;
	r1 = tex2D(g_Sampler1, r0.yzzw);
	r2 = tex2D(g_Sampler0, texcoord);
	r0.y = r2.x * g_MatrialColor.x + r1.x;
	r0.x = r0.y + r0.x;
	o.xyz = r0.xxx * 0.99;
	o.w = 1;

	return o;
}
