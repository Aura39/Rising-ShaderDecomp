float4 g_MatrialColor;
sampler g_Sampler0;
sampler g_Sampler1;
sampler g_Sampler2;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	r0 = float4(-0.001953125, 0.001953125, 0.005859375, 0.001953125) + texcoord.xyxy;
	r1 = tex2D(g_Sampler0, r0);
	r0 = tex2D(g_Sampler0, r0.zwzw);
	r2 = float4(0.001953125, 0.001953125, -0.001953125, 0.005859375) + texcoord.xyyy;
	r3 = tex2D(g_Sampler0, r2.xzzw);
	r4 = tex2D(g_Sampler0, r2.xwzw);
	r0.y = r3.x + r4.x;
	r0.y = r1.x + r0.y;
	r0.x = r0.x + r0.y;
	r1 = tex2D(g_Sampler0, r2);
	r0.x = r1.x * -4 + r0.x;
	r1 = tex2D(g_Sampler1, r2);
	r2 = tex2D(g_Sampler2, r2);
	r0.y = r2.x * g_MatrialColor.x + r1.x;
	r0.x = r0.x + r0.y;
	o.xyz = r0.xxx * 0.99;
	o.w = 1;

	return o;
}
